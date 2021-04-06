#
# Basic tests for `service.rego`.
# TODO add test cases for corner cases, e.g. missing fields.
#
# To run the tests:
#
# $ cd poc/deployment/opa/rego
# $ opa test . -v
#

package fiware.service


test_deny_expired_token {
    not allow with input as {
        "attributes": {
            "request": {
                "http": {
                    "headers": {
                        "fiware-service": tenant,
                        "authorization": expired_token
                    }
                }
            }
        }
    }
}

test_deny_tenant_mismatch {
    not allow with input as {
        "attributes": {
            "request": {
                "http": {
                    "headers": {
                        "fiware-service": "dodgy-tenant",
                        "authorization": valid_token
                    }
                }
            }
        }
    }
}

test_allow_valid_request {
    allow with input as {
        "attributes": {
            "request": {
                "http": {
                    "headers": {
                        "fiware-service": tenant,
                        "authorization": valid_token
                    }
                }
            }
        }
    }
}

tenant := "yer-creepy-tenant"
valid_token := "Bearer eyJhbGciOiAiUlMyNTYiLCAidHlwIjogIkpXVCJ9.eyJleHAiOiAxMDAwMDAwMDAwMCwgInRlbmFudCI6ICJ5ZXItY3JlZXB5LXRlbmFudCJ9.nDLMDKcyYO83gOjTfUnmbi6P6lcVgmwLxDZj1lAi5M7cyK-AILFrWMyXoGUttO_RPwwiPaNYkFx70Oj0eCEfjgyvT0aJeRSNTGD0caYhc5f2wJkgA3r7Ax6jlIXl4149rlA5VzHaTFRQHuy6wBOpydHXpDoCtQ1uFm4-IAAAeAqNYn8SU_Tc04XELM1JzIRtXb4onSiIYTKsQILjr59t-0nlDfUxoF9UR3Yc3Q-zv3TLGzDBwlqqc68NEqL1UyeCS-MZPTACkwXkYg9qSbZQnmCxBH4vJf3OKDDZ-JBTbfOtsmZjJv3FGy9DdBgYWcuCn0t6vLIZtpZF0J_EGcJWyA"
expired_token := "Bearer eyJhbGciOiAiUlMyNTYiLCAidHlwIjogIkpXVCJ9.eyJleHAiOiAxMCwgInRlbmFudCI6ICJ5ZXItY3JlZXB5LXRlbmFudCJ9.Je3kew_18HXIM_E5c_zdX-4Z9tnfIuYYw6ZjCf-N-5-dfK_MrURhv4-1iCv5Ofp3LFQQRkrmtDWE-tq4klL9vR2elC4L62yf8R5FIf9kYteOoKg9tiwtLo-fdU6B19HcCUXQPmMzO5qS08Szrf8EVNiW17uWP8RRpboUgtFKzZOp6Ma16b65rMsnsgpW8RaEeSHyoQdCxA4m7WAm_p6oQgGh6950LfGLr7AeKjHziuAGaWEA8z4G3KmxdMyy-vTSBaHhyJdAqb5aiaaqWKqMjBaMXkeqe9dmxhRSd66QHcSKitkjJ8UH6qGhysC30Zel2ad5mxO7zZLn9rb2kt8pBQ"
