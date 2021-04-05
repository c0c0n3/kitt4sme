#
# Check an HTTP request to a FIWARE service is valid—see below for the
# details. Notice the checks below are, in general, not enough to go
# ahead with the request, since typically you'd want to check scopes,
# etc. So while you can use this policy as a first step in an authn/authz
# chain, you'd typically supplement it with other policies.
#

# TODO change tenant
# opa eval 'allow' -i fiware/istio-example-input.json -d ./ --package 'fiware.service'
# opa eval 'data.fiware.service.allow' -i fiware/istio-example-input.json -d ./

package fiware.service


default allow = false

allow {
    valid_request
}

# An HTTP request to a FIWARE service is valid if all of the statements
# below are true:
#
# * the request holds a valid Bearer token—see below for the details;
# * the token has a `tenant` field with a non-empty value of `t`;
# * the request holds a FIWARE service header with a value of `s`;
# * `s == t`.
#
valid_request {
    count(claims.tenant) > 0
    claims.tenant == input.attributes.request.http.headers["fiware-service"]
}

# Verify the Bearer token and extract its payload.
# Check the all of the statements below are true:
#
# * the algo in the header is the same we expect;
# * the token signature is valid;
# * there's an `exp` field in the payload holding a valid date `d`;
# * `d` is in the future.
#
# Plus, if there's an `nbf` field in the payload, check it has a valid
# date in the past.
#
claims := payload {
    [valid, header, payload] := io.jwt.decode_verify(bearer_token, {
        "alg": "RS256",
        "cert": pub_key
    })

    # Assert `valid` is `true`.
    valid

    # Assert there's an `exp` field in the payload.
    # If true, then `decode_verify` must've checked `exp`'s value is a date
    # in the future. We need this since if `exp` isn't there, `decode_verify`
    # sets `valid` to `true`.
    payload.exp
}

# Extract the Bearer token from the HTTP request if present, otherwise
# set `bearer_token` to `undefined`.
# NB this is a copy-paste from the Rego playground JWT example and needs
# to be a bit more robust.
bearer_token := t {
    v := input.attributes.request.http.headers.authorization
    startswith(v, "Bearer ")
    t := substring(v, count("Bearer "), -1)
}


# RSA public key to check JWT signatures.
# See `rsa-key-pair.rego` for the details.
#
pub_key := `-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqM88PI71ThQgHbXSJ0tp
SpkgzD8+/5nKaWer0Q9mlR21eDYE/c4esH0DzGlVUxVv4BUUhLz66YB/oGzTKTnW
GMXfk1eAWF8zfyOYM/3C2OZAYu/bSaaUyTtn/TjVrXkefuanmKmVId93aNTceVeU
mZJ1x9ihY4IsbOJebxv0Zsjvh6xsDU90Ck4ohxPbon5T9e6R37tM6wm9rD6TcOke
YYeP4z4mVfamagp4ZPJC0Y4hdbAB92gDM4+EP31yvFxhyiq3ElR+3O6AIMGMTh1C
fbJNuRaf/MfnYRxMpPc8WKH8cCHNSXgA5Ikvx+Yi3fEGF8Xa3h1H0NX48UVf79sF
wwIDAQAB
-----END PUBLIC KEY-----`
