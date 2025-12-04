# This file is maintained automatically by "tofu init".
# Manual edits may be lost in future updates.

provider "registry.opentofu.org/fluxcd/flux" {
  version     = "1.7.6"
  constraints = "~> 1.0"
  hashes = [
    "h1:4eLKXZfwLpXczPpLUruvbWaSY1ZMguCtlWXUB2Kf3NQ=",
    "h1:AXSsCtxSNwF8D/b7I0sZ1A0C2SIIawvsqrRKpqWbWBk=",
    "h1:D2tpVa4fxqPv9aClFUQrSCinJEC88bzsxuG5rBRw6xY=",
    "h1:M6aL4yF6pkzTsLCPmu6Jn7Tcln66ycLybN32p7xXgtQ=",
    "h1:Zciva4ZlK4Oqg6cAnFoKUOVpEkJvZx/xbCvE4xbFSWY=",
    "h1:b/AKqBFvcKsugXe+8LtXHZerTG3l7lNWywRlxjPPBHo=",
    "h1:b/L9PO9w6HyuzM0+8XwGhbVApSN4HmXeIlFclUWDJxY=",
    "h1:fu8xug4wWBpK8TLULX/B187uVm4l5oo1sNFKoMAEsCI=",
    "h1:kJL1IL0fGlb1T6lAF6bbaHx6ARu+jECIJx+Z8UfyE8U=",
    "h1:lLSez51qlErsUTW6HHsgbGxjgs70qO88GS8IUNRt5tc=",
    "h1:rTN6yArT8dBH7qzGieKOMZuVbZ+vQJPtYYI4iGTf0K4=",
    "h1:sIKocCXM2SUI6zCyxIm7vW0qxXD0rv3mB9N64CBWuEQ=",
    "h1:vLAi6AkxYlmVgmrQrhnOvyIgN1H/kupHUZ8/p2g3bog=",
    "h1:vgLG3VTwALIkcAMal5anrtePxzXWlQj36rccsaXKF+U=",
    "zh:08f1d43cc4d0d73beb26e433126ef68434ae1b88a945f3c7403e93ef8ce40b16",
    "zh:0a27c7876f2399a66049deae0a2f0ba2233a8eddd3a45560eff6e20dac279317",
    "zh:199ba361e9cbbb0289094480be7d1cdaae1796dcdbddb40bf5d3ee9c5aeb4483",
    "zh:44ea3043649059b6884031b9e31016fad62dcb1e724dae29e5012a8ad4007039",
    "zh:467f67a39b60ff247ead85d689cbdbaff2baac7693804a2a24857cb4824e2cc6",
    "zh:4b910e6a1e4b65e838d4f2bb5965ff4b54ea315b35ae60ee5b17ceed1a75d11a",
    "zh:5418c8ca39db1bb5e65edc4a976d3cb0140b30cbe63814287a3b7f36f14978ec",
    "zh:6a2dad787674fd2219cb6a6d72d2e77500aba1c5b527db7c3e4d6fedb10d40db",
    "zh:7cf60dc7fa3a7f9323aa8d036e931348482fb69340e6238caff21ec49e941bef",
    "zh:8802c20134830ea46ef9214498c0539d3b63d7b0d0af82cfa6731ca7d41390c4",
    "zh:9f20bcf0fda0ac6a3a162566537d8319bec377617cbec58d4c0805c9088d107c",
    "zh:ace15c081c466984beecee05b9b072bfdf563020eccab6ed6ae7004238602f82",
    "zh:d39a431d592629c23a4fb04ebc44c24b2bc68f03c5b85d5830fb21da0f025d9b",
    "zh:fce784eb774155ccd9a87663d2dc9aa3e82e4fd495d8adb304301adf756a8f63",
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
  version     = "6.8.3"
  constraints = "~> 6.0"
  hashes = [
    "h1:+h7Q2tm56IyqjPzKZTTCL6LxX/ZngHdi1Qq2BOov0/0=",
    "h1:6+CTf/yJygDJsN3fTgoYonMmjpsytn9KrzXcdBhHdmc=",
    "h1:Amcb2X/Z9ZtvEpptxpobgCsjGzWa0hyxEeKsWS0ZdaI=",
    "h1:CGIe2MaHu7319hVgXpuDzrTCR7Pl05y/oFNMxM2X9PA=",
    "h1:CzHXqIZNthb5GqnsGKevEIUZiZpZsDiOBy1vgYSuL5Y=",
    "h1:DWfkFX3DAQ98CySN1c1pHbmU0j2VjSNyADW6FJ/DtR4=",
    "h1:L6vZqEZkJbqdJHLXIJ6ImwpwM2AIJXetKRlJezf5G/I=",
    "h1:LnpUTEWVHV5GToNxS239VLFPXWw2Hhe21/GuUTKhR9o=",
    "h1:XTzjbd18ZSIFs0njGlQkbmWw/om/w3cm1wSnSXZ53Gg=",
    "h1:Y1w3H/xP4zW0jEpbQfhXGMdpvGn8jEz2Md2TVaNqSiE=",
    "h1:aJDtXRORhhNljqxf8V8zE2PGXs0clB1NO9zR2Kduf2E=",
    "h1:dXLVBDCqPeXKgzoJqoQr/uAc9QJATqkZmntmwrP0pi0=",
    "h1:jk5L3i32ZyAuUgJg9UKAgXSlk0HSqOx7zICE6PrmGR8=",
    "h1:p+MYUx31Ithml+XI1jJAmo/DLkePxBOAbmqIxHLYevQ=",
    "zh:0795635834c762371aae1748f68d17db778918f48a630c69e673e0339edc0869",
    "zh:191649a4ca68b8c5235712247b9ae05b16123e912c8e0f875267df68fda64452",
    "zh:3a5260d0af06c37a346e9397f7563e03247c99906b4d2df9d615ab72a6a2dde1",
    "zh:57b5f57e45a84124780ebc5b2ffb40926a513dfdd45193eab137634c765db5b0",
    "zh:639568914b977203fa3f94dc55c256022f800daaaeb66084e01302cffda9d933",
    "zh:8976e4963db88a5ad8209f0422754f2aa75220f12123228804cc97169f701ee0",
    "zh:971e1021c45ab06caa966030494957c0e87bd9e30cd8358e41aaf8c120352186",
    "zh:9e379ed9235f5dadb4c5b625016a474961d39fba5753a3155f3dda56446f0ec2",
    "zh:a50e5e02cd99479d8bc9b06c428b610562986931ba258b45c09f2dec76711086",
    "zh:b421552318952b2fa30ef30b4279b56620bddef65d11cbda1cfa123be5a3bf9c",
    "zh:bc8bf3a88b9daaca1ce1e5b3e59be8ae0be504f111106094de791e19e0e49c9d",
    "zh:d3f9b1d8ed5a58a8e22aa20e3d76dc7afe83f648a41ff996e445de0c6a1f13cc",
    "zh:dc55d47cb73f633e9f5d4ebcfba1a2212b6e83fcb7a6c7487606324053a2943f",
    "zh:dfc8e85505e3ce90673b460833e94d935142145b79265912c3c805d8de12c4f2",
    "zh:fbd1fee2c9df3aa19cf8851ce134dea6e45ea01cb85695c1726670c285797e25",
  ]
}
