# This file is maintained automatically by "tofu init".
# Manual edits may be lost in future updates.

provider "registry.opentofu.org/fluxcd/flux" {
  version     = "1.7.4"
  constraints = "~> 1.0"
  hashes = [
    "h1:ghEypxw0SCvu5f15mOTmfi9fiKH7THnpJkhmy9JQOqM=",
    "zh:102af2c2945833631699a909d28d4a9054ecd3d16edca6a40438de39e89a926e",
    "zh:351e57ddba51f19d453cd1c74eff1c5f443ed7be0e6a1d0df1e67aee48fd73ea",
    "zh:4632f8c7c2b7ef6f616084e765afe80a0f9978ba712c9e79052cd6b73b7986c3",
    "zh:5c682b2940b092080a509372f54354bbd95a75b92272f9df913e247276d0324c",
    "zh:6de0c5cc5ca3d0ca1b0a523526c1c3cdabf0d5d606da83d4e0cb828733ec3173",
    "zh:847da79291cb4c89dd01d9a926db95bf4984dd7759f399ae9cbc520cfb3f8890",
    "zh:95b40a88fca06769fafb1ce52f1804c5abcddf021af9de8df9a1caed6f244535",
    "zh:a274d056429192c35eb448e9e288c6bc9cd199996a29262cedb3d9f46577fdf9",
    "zh:a528f64f026cfb80496897136b481a75840c12cf89bfa1abf2126b5ec5e22592",
    "zh:cae6ce1851e8a142215a69954c60caa7c190785b5f0fd22335440b6f50a24780",
    "zh:de22cc9b663098e6a3437aebfa339d03930aededf3ece0e9d3a014eb096d623b",
    "zh:e7241c40ee675e935d449be0778b5c984273dd23457e9b8bc1d698a4bc947f1e",
    "zh:f211bb924a27fba91935ec63e38d134500df33bffbb8fad7bc6e391a0cbc7871",
    "zh:f6231b9be17f1ec5a59d98ceaee11f9b9d54b9694acf420a20d2aba31fe740fd",
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
  version     = "6.6.0"
  constraints = "~> 6.0, < 6.7.0"
  hashes = [
    "h1:P4SRG4605PvPKASeDu1lW49TTz1cCGsjQ7qbOBgNd6I=",
    "zh:0b1b5342db6a17de7c71386704e101be7d6761569e03fb3ff1f3d4c02c32d998",
    "zh:2fb663467fff76852126b58315d9a1a457e3b04bec51f04bf1c0ddc9dfbb3517",
    "zh:4183e557a1dfd413dae90ca4bac37dbbe499eae5e923567371f768053f977800",
    "zh:48b2979f88fb55cdb14b7e4c37c44e0dfbc21b7a19686ce75e339efda773c5c2",
    "zh:5d803fb06625e0bcf83abb590d4235c117fa7f4aa2168fa3d5f686c41bc529ec",
    "zh:6f1dd094cbab36363583cda837d7ca470bef5f8abf9b19f23e9cd8b927153498",
    "zh:772edb5890d72b32868f9fdc0a9a1d4f4701d8e7f8acb37a7ac530d053c776e3",
    "zh:798f443dbba6610431dcef832047f6917fb5a4e184a3a776c44e6213fb429cc6",
    "zh:cc08dfcc387e2603f6dbaff8c236c1254185450d6cadd6bad92879fe7e7dbce9",
    "zh:d5e2c8d7f50f91d6847ddce27b10b721bdfce99c1bbab42a68fa271337d73d63",
    "zh:e69a0045440c706f50f84a84ff8b1df520ec9bf757de4b8f9959f2ed20c3f440",
    "zh:efc5358573a6403cbea3a08a2fcd2407258ac083d9134c641bdcb578966d8bdf",
    "zh:f627a255e5809ec2375f79949c79417847fa56b9e9222ea7c45a463eb663f137",
    "zh:f7c02f762e4cf1de7f58bde520798491ccdd54a5bd52278d579c146d1d07d4f0",
    "zh:fbd1fee2c9df3aa19cf8851ce134dea6e45ea01cb85695c1726670c285797e25",
  ]
}
