# checkout-private-action
This action checkout your private repository using Github Apps.
You can use other private repository github actions code.

## Prerequirements

### Github Apps

To checkout private repository, you need to create [Github Apps](https://docs.github.com/en/developers/apps/getting-started-with-apps/about-apps), and install it in your orgnizaions.
This Github Apps need contents read permission.

Then, you need to keep github apps id and private key. We reccommend to keep these in github actions secrets.


## Usage

```
# .github/worlflows/example.yml

jobs:
  eample:
    # Assumed to run on ubuntu
    runs-on: ubuntu-latest
    ...
    steps:
    # checkout `<organiztion>/<repo>` contents to `./github/actions/common`
    - uses: caddijp/checkout-private-action@main
      with:
        app_id: ${{secrets.APP_ID}}
        secret_key: ${{secrets.APP_SECRET}}
        org: "<organiztion>"
        repo: "<repo>"
        ref: "main"
        dist: "./github/actions/common"
    # use action in checkout contents 
    - uses: ./github/actions/common/some_actions1
      with: ...
    - uses: ./github/actions/common/some_actions2
      with: ...

```

## Limitation

Now we assume that this action run on ubuntu.

