# This file is maintained automatically by "tofu init".
# Manual edits may be lost in future updates.

provider "registry.opentofu.org/fluxcd/flux" {
  version     = "1.7.3"
  constraints = "~> 1.0"
  hashes = [
    "h1:z1Ck1826iZl1O7Yz0Iuc3WQ/kTb7GpIFguBiX2YOQzA=",
    "h1:zOC/gIFvMacBIQ/hc1rQNk82ykANOaMHGs+V87M6D4Y=",
    "zh:0147dfdd040800de1b00a8fe92281bb592332b8ec65ace77c566f99b48989226",
    "zh:2dfa53c20bf91763c7a3b88366e2f8a082f75825e444db31fa048e718692bfe4",
    "zh:40b0b79a2244d4152e1ec733a14184d4d117bf4b5f385a8967bce3772a75f820",
    "zh:43a6ec30e67b485baa7cbaca4ca8c95afb0f08eb0a76185346fd32c4a0bb92bf",
    "zh:7333d831698812b261f738f3022a9a87b39985d8f37781573fcb8afa20d0ebf9",
    "zh:7d6d6d5890f542753aafa62d5618cafcfcdfe7e2602a4d60a3befed79ce30ca9",
    "zh:90e110ad6782f765ee041b8ca45d752612cb0b73f4d934f518377d2d749f8ff3",
    "zh:aab4b2cbec68fcaf16aba64468dfe2634f68f3bc5697e15359b0be85382cf8eb",
    "zh:b06b77edfa35e022ae7b5fa9241db3f6c6a65f1153db78afcd92cc9749561e2d",
    "zh:c62521f26747948e878fdc325606c5dbb7e9be2d1c1abad1d18ce2c072d9e385",
    "zh:d41b188d560353e05a33cca8f11442c52e68757c7298a8bda505b659545ac25c",
    "zh:dc995b812ea123f8ca78837f22c2d6224e53d0d16e796d8f104d3c7eb008e36e",
    "zh:dcd5889504c9b7ca274935ff211acc88b575cb1c0b514d39f10a717f4a87b6ff",
    "zh:e2f1252c3b826e8107aef834f61cac214eaabd31ad242f261db42bd760f02386",
  ]
}

provider "registry.opentofu.org/hashicorp/kubernetes" {
  version     = "2.38.0"
  constraints = "~> 2.0"
  hashes = [
    "h1:ems+O2dA7atxMWpbtqIrsH7Oa+u+ERWSfpMaFnZPbh0=",
    "h1:nY7J9jFXcsRINog0KYagiWZw1GVYF9D2JmtIB7Wnrao=",
    "zh:1096b41c4e5b2ee6c1980916fb9a8579bc1892071396f7a9432be058aabf3cbc",
    "zh:2959fde9ae3d1deb5e317df0d7b02ea4977951ee6b9c4beb083c148ca8f3681c",
    "zh:5082f98fcb3389c73339365f7df39fc6912bf2bd1a46d5f97778f441a67fd337",
    "zh:620fd5d0fbc2d7a24ac6b420a4922e6093020358162a62fa8cbd37b2bac1d22e",
    "zh:7f47c2de179bba35d759147c53082cad6c3449d19b0ec0c5a4ca8db5b06393e1",
    "zh:89c3aa2a87e29febf100fd21cead34f9a4c0e6e7ae5f383b5cef815c677eb52a",
    "zh:96eecc9f94938a0bc35b8a63d2c4a5f972395e44206620db06760b730d0471fc",
    "zh:e15567c1095f898af173c281b66bffdc4f3068afdd9f84bb5b5b5521d9f29584",
    "zh:ecc6b912629734a9a41a7cf1c4c73fb13b4b510afc9e7b2e0011d290bcd6d77f",
  ]
}

provider "registry.opentofu.org/hashicorp/tls" {
  version     = "4.1.0"
  constraints = "~> 4.0"
  hashes = [
    "h1:MByilNnYPdjPTlb/qcNgR0DErA6550hI6wd8OJYB1vw=",
    "h1:yNZuPWUgw6Ik2huf9lhsuCGONWo2rsY1MfeceT0BQpw=",
    "zh:187a99f0d236fd92da224e2f026c4ca8f1dcbf2b5cddc8e6896801bacfab0d73",
    "zh:61a32a01cc46f382014dcf7aff5bcac61fe97bd69d3ccb51c801e9437ecdb9ce",
    "zh:683ba18baa2cc336ff83f061b5e4569e2cd7c4a097b53a2d80bb0a26be2fc59a",
    "zh:85c7640ea13dcf5ae5f7f3abbf2f21e4b93ce7f333ffee5b4a6acd6b5fe71223",
    "zh:882f2c5214fd6d280a500acfd560925a71030ef70e10d11fa2b94815b58ae9b6",
    "zh:97cb5e0b81b8687870a6b8a16e9a9cfe546e2fdb7534bdd8302eda0d66393f78",
    "zh:c0a0110b15ce45140036fe5bf5a44cb822c2f55b30ff2770faf37d7c3cae3b5e",
    "zh:d98c1c63fd0c76704fd7be38c316c305a2c95f3215330f2fb1e6b0b7081bf8e9",
    "zh:e703a7adf220ac436f8ebfd06529de865b965fcfc461c7ef7b71afa0de04c8e9",
    "zh:e93e241150cd438a0708679cb4aa7976742fde02f4c1725cfdefc405c4eeca1a",
  ]
}

provider "registry.opentofu.org/integrations/github" {
  version     = "6.7.0"
  constraints = "~> 6.0"
  hashes = [
    "h1:3E/amdf0gMP4ZFbkYH2aTklkNEzJpXyCIzdodA8zvmQ=",
    "h1:644OkjJEt+cYgdurcYkS6uVk39DoShWil47vXRAz6gc=",
    "h1:H5qQPZnxlkCpVxgWPuJfhO9yjKoP7BfgKYBucrksNuE=",
    "h1:ICPFp4Iu1kvssX0Jj3lwV2KaMNjgEL0avIaYTwgM2zw=",
    "h1:KWaMVViA+VwUN/1lxW/8VBPccuzM7dny0vG+P5Y8rv0=",
    "h1:KcDTtSwRpsGQSQjl0cKtGY1YU4QMYZiWbQrMnJIBa00=",
    "h1:QYuejDAJR8wR1DKPqco45AkzTv+z1ezVvww7Bidb5+I=",
    "h1:SWyj4eIKaGCIkk+oDwu4e4McEVwxIhWjleB9FLa6B2w=",
    "h1:Z1f917DLEdJ3C/+9Br68IMvg3sSLlZ5DMLRFS5lI3s0=",
    "h1:aAtBhxW3fTudhqdnMVJDD96pMPTOcO9bkvfmU+tHZEo=",
    "h1:d1zGnSk1vR2qDtXx1flh4Py9nSQAWWcqSg0q3aLWpZA=",
    "h1:oQkKe24RVEPK2v73hkjysp5YuVaE7TJQjrdIrR+8FAM=",
    "h1:vJwp2IaEoqucdLTg2AgCZODr0rcJwpCWNnrnOM0fxR0=",
    "h1:zb0H0knEgNrOg8xp2mY0Fka2q1Ow6M/cA0E4zYSkKls=",
    "zh:0d3d2ebfffce6d7c9d1a365a8fd136872f63ca6dcb3db8b9a9ad4e81a5b69fa7",
    "zh:198ffb855d367a3d2371c2152dc80f977a4a880d5ce49747f9290c6ca411f1bc",
    "zh:350c0e996e1650036beaaf2d3e063cb1e8d1693e7fcf7754df6e7453b49c089f",
    "zh:544bb0ba8203d7caa688d46cb926e12142356236ab29b21afc54eb02652852c7",
    "zh:8698340cd268e271f68cfb757d40b4a41efc1399deb7232ba2842c9d4c6ba6cd",
    "zh:95d9da04a3a9f81edd1f3354ba98f2a39a17b7fd6ddf7671a7dcd6d422108d24",
    "zh:9bd1e6e2930f9fa596a0498b79b33cf369211b4252bd88e7f2cb703fbcdb7051",
    "zh:a1b9dbdc975743d95545bdeebb33c84963437b02f16a4ba52868a8a0ebe94763",
    "zh:acbdb49609b17be783bec8069a833747bb03eb19b0cb0877bcbd4783bbf855ce",
    "zh:ae23023b3f65cfcbd3d0291baf9215ab055a3b48f0d9a4a7c1b09ec4e56553d5",
    "zh:c8fbd050b94f80cd69c3e331546a411611eef4f29b97fcb50b886de375f25cd9",
    "zh:ce2832f39173e5f2906a8ab8822ec320085512381693bef2ba6ca8c6969e6085",
    "zh:d15357ec50598afe3ae1e3c013f063a8bb9a86bc2e2f6d5bf2abee231b1aaeaa",
    "zh:e77878043cfa9cdbf1e33b7f60a0b2d193dfe37a85da6b3fdfd4f95a6ff27255",
    "zh:fbd1fee2c9df3aa19cf8851ce134dea6e45ea01cb85695c1726670c285797e25",
  ]
}
