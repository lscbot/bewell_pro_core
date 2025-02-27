# Be.Well Professional Versioning

## Custom versioning policy

For Be.Well professional, we needed a unique number for our versioning that would not conflict with the play store submission process. Instead of incrementing the app version manually, we would let out CI jobs do it for us.

We, therefore, decided to settle on incorporating the CI job ID into our versioning scheme for the purposes of automation. So, we use a combination of the `build version root` and the `CI job ID` and finally the suffix of the channel the app is to be deployed to. This helps prevent a lot of mistakes internally especially when doing submissions to play store

Sample version numbers can be for example:
| Build version root | CI job ID | Suffix | Complete App Version |
|--------------------|-----------|--------|----------------------|
|1.0 | 87565|prod | 1.0.87565-prod|
|1.0 | 87562|beta | 1.0.87562-beta|
|1.0 | 87559|alpha | 1.0.87559-alpha|
|1.0 | 87502|internal | 1.0.87502-internal|

## Updating the versioning

When updating the app version follow the steps below carefully,

### 1. Update the changelog file

This can be done by combining the changes from the merged MRS since the last release. For more details on how to write a good changelog file, check out the [changelog-docs.md](changelog-docs.md)

### 2. Deploy to the alpha channel

For more info on how to deploy to the channels, check out the [Deploy and release to alpha (Play Store)](https://gitlab.slade360emr.com/optimalhealth/bewell-professional/-/wikis/Deploy-and-release-to-channels#2-deploy-and-release-to-alpha-play-store) documentation in the [Be.Well Professional Wiki Page](https://gitlab.slade360emr.com/optimalhealth/bewell-professional/-/wikis/home).

### 3. Update the version in the changelog file

After deploying in step 2 above, get the latest version from CI and append it to the changelog file
