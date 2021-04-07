#
# Constants to hold the RSA key pair we use to sign and validate JWTs.
#

package fiware.service


# Constant to hold the RSA key pair in PEM format.
# The pair got generated with:
#
#     $ openssl genrsa -out rsa.key-pair.pem 2048
#
# To extract the public key, run
#
#     $ openssl rsa -in rsa.key-pair.pem -pubout -out rsa.pub.pem
#
rsa_key_pair_pem := `-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAqM88PI71ThQgHbXSJ0tpSpkgzD8+/5nKaWer0Q9mlR21eDYE
/c4esH0DzGlVUxVv4BUUhLz66YB/oGzTKTnWGMXfk1eAWF8zfyOYM/3C2OZAYu/b
SaaUyTtn/TjVrXkefuanmKmVId93aNTceVeUmZJ1x9ihY4IsbOJebxv0Zsjvh6xs
DU90Ck4ohxPbon5T9e6R37tM6wm9rD6TcOkeYYeP4z4mVfamagp4ZPJC0Y4hdbAB
92gDM4+EP31yvFxhyiq3ElR+3O6AIMGMTh1CfbJNuRaf/MfnYRxMpPc8WKH8cCHN
SXgA5Ikvx+Yi3fEGF8Xa3h1H0NX48UVf79sFwwIDAQABAoIBACZ9cg+gzP/riNMd
ZPh+slhHB/pqJVQkXcmg0MVPTKWNa5YoQwUX3VmCd75A+iqChcrDI7WMXW2mVfNf
PNp2jIGDhJHU7re3pUdE92xLXQUVovKsHAT0DZLAj9pl/hqatkBbGTWu3QknKdPm
TQsB1CkcAuz5UPsecEC3cK7G4fgZU+UzbRqYv2lWFGy8HmSw78MDxIkOrMxeiDi+
Q4hrHV52hGgbc/g20oyMLSgPT8TAnLlgurLbOC1j4ft2/WKfOBuCTZyw67R4Gsdw
EYMmmCBXd0ZoXlctv4+TOsOeHPD6iCd06Ey4Wrn438EL/neabs4oBZtBixRAVRxf
uVa7/3kCgYEA1g/bW7W443b87MUGS5V+0CyW8Gz2Ut2Q8I0hezDl20Dw2wjzpaJp
ktEOL38IhBjlD7vqaEJG8kT30pW9/gsvyGndmCy7+lRXtOdF7ixJC0eB4fJkRPxR
nC0DeKpemrmcu13JOlohzZzZySpB4AbHLV2wEjcUsB5E4apsXiitC/8CgYEAyeHF
aLUYixeDxreKuaZj6pPzXbq8hCJIBFmB7XXYx3Fz3Ng81IzJE3ipnKa5HGEt2XKv
NTg9b460fHIjfaQ6uGgODnwW1zAJxywSQhi2iehmmSSrqUjcAnB5EYk0AcNZUUdM
mmBgx7Q9J13dSLB26lhreyBgFCnQXpWNyUlo1j0CgYEAjzuU/8ycpjdcDeHX0IN7
kzgC12VRfSkcbplAqfmSFB9kCmv2/AGsurx/zXAm9pzhyKFou9J9Pma/nHzt4CsE
EgokaEqmjV4aQcXumOuxBIcYdWOHjFF5GhNUm00EeGtyYDzlBNKCg95MK7rG0Ww3
ojdqNQX+JcpbNNSgJnD5OWkCgYB4wkY1he4ydVRr76pZtsAZt3ph3KubVm5Bu9DO
XCnZ03F87xQkCDrXHNxISip8YVztr35ClWuaaYBo2FWGeFBvsj6GR4/aFHAk5aXe
R64Y/B0zCg5s6ppAE0s4RBwJ2fJ5fe7CgVgi3RufirQtIPFg6JcSRaFzLjfn/Ame
F/1P+QKBgEfmvJNwPbZ7LhYi2TKA1u35JSs20CcrmOuaxRF+BvoTsEqhPdpdYTVB
9xu7jj+rv0aBfNA1v+CcSaoDZ3iROSFvpzEdgtFmBSZx60uhp+dgEQaFO9lIKQr2
B26jVZku6iV1uAZYe1kuvy8RAv6N4LrHsOPD88wm7Uf5/UQXq/e4
-----END RSA PRIVATE KEY-----`


# Constant to hold the RSA key pair in JWK format.
# It got generated at
#
# * https://russelldavies.github.io/jwk-creator/
#
# by entering the above RSA pair in PEM format, selecting "Signing" from
# the "Public Key Use" drop-down menu and "RS256" from the "Algorithm" menu.
#
rsa_key_pair_jwk := {
  "kty": "RSA",
  "n": "qM88PI71ThQgHbXSJ0tpSpkgzD8-_5nKaWer0Q9mlR21eDYE_c4esH0DzGlVUxVv4BUUhLz66YB_oGzTKTnWGMXfk1eAWF8zfyOYM_3C2OZAYu_bSaaUyTtn_TjVrXkefuanmKmVId93aNTceVeUmZJ1x9ihY4IsbOJebxv0Zsjvh6xsDU90Ck4ohxPbon5T9e6R37tM6wm9rD6TcOkeYYeP4z4mVfamagp4ZPJC0Y4hdbAB92gDM4-EP31yvFxhyiq3ElR-3O6AIMGMTh1CfbJNuRaf_MfnYRxMpPc8WKH8cCHNSXgA5Ikvx-Yi3fEGF8Xa3h1H0NX48UVf79sFww",
  "e": "AQAB",
  "d": "Jn1yD6DM_-uI0x1k-H6yWEcH-molVCRdyaDQxU9MpY1rlihDBRfdWYJ3vkD6KoKFysMjtYxdbaZV81882naMgYOEkdTut7elR0T3bEtdBRWi8qwcBPQNksCP2mX-Gpq2QFsZNa7dCScp0-ZNCwHUKRwC7PlQ-x5wQLdwrsbh-BlT5TNtGpi_aVYUbLweZLDvwwPEiQ6szF6IOL5DiGsdXnaEaBtz-DbSjIwtKA9PxMCcuWC6sts4LWPh-3b9Yp84G4JNnLDrtHgax3ARgyaYIFd3RmheVy2_j5M6w54c8PqIJ3ToTLhaufjfwQv-d5puzigFm0GLFEBVHF-5Vrv_eQ",
  "p": "1g_bW7W443b87MUGS5V-0CyW8Gz2Ut2Q8I0hezDl20Dw2wjzpaJpktEOL38IhBjlD7vqaEJG8kT30pW9_gsvyGndmCy7-lRXtOdF7ixJC0eB4fJkRPxRnC0DeKpemrmcu13JOlohzZzZySpB4AbHLV2wEjcUsB5E4apsXiitC_8",
  "q": "yeHFaLUYixeDxreKuaZj6pPzXbq8hCJIBFmB7XXYx3Fz3Ng81IzJE3ipnKa5HGEt2XKvNTg9b460fHIjfaQ6uGgODnwW1zAJxywSQhi2iehmmSSrqUjcAnB5EYk0AcNZUUdMmmBgx7Q9J13dSLB26lhreyBgFCnQXpWNyUlo1j0",
  "dp": "jzuU_8ycpjdcDeHX0IN7kzgC12VRfSkcbplAqfmSFB9kCmv2_AGsurx_zXAm9pzhyKFou9J9Pma_nHzt4CsEEgokaEqmjV4aQcXumOuxBIcYdWOHjFF5GhNUm00EeGtyYDzlBNKCg95MK7rG0Ww3ojdqNQX-JcpbNNSgJnD5OWk",
  "dq": "eMJGNYXuMnVUa--qWbbAGbd6Ydyrm1ZuQbvQzlwp2dNxfO8UJAg61xzcSEoqfGFc7a9-QpVrmmmAaNhVhnhQb7I-hkeP2hRwJOWl3keuGPwdMwoObOqaQBNLOEQcCdnyeX3uwoFYIt0bn4q0LSDxYOiXEkWhcy435_wJnhf9T_k",
  "qi": "R-a8k3A9tnsuFiLZMoDW7fklKzbQJyuY65rFEX4G-hOwSqE92l1hNUH3G7uOP6u_RoF80DW_4JxJqgNneJE5IW-nMR2C0WYFJnHrS6Gn52ARBoU72UgpCvYHbqNVmS7qJXW4Blh7WS6_LxEC_o3gusew48PzzCbtR_n9RBer97g",
  "alg": "RS256",
  "use": "sig"
}
