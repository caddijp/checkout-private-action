# checkout-private-action

**NOTE!** Now, actions of the same owner's private repository are able to uses directly.　Please see [this article](https://github.blog/changelog/2022-12-14-github-actions-sharing-actions-and-reusable-workflows-from-private-repositories-is-now-ga/)

This action checkout your private repository using GitHub Apps.
You can use other private repository GitHub Actions code.

## Prerequirements

### Github Apps

To checkout private repository, you need to create [Github Apps](https://docs.github.com/en/developers/apps/getting-started-with-apps/about-apps), and install it in your organizations.
This GitHub Apps need contents read permission.

Then, you need to keep GitHub Apps ID and private key. We reccommend to keep these in GitHub Actions secrets.


## Usage

```
# .github/worlflows/example.yml

jobs:
  example:
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

