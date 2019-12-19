# Koha Branch by Label

This action returns the current Koha branch name for a given version label.

## Inputs

### `version-label`

**Required** Label of the Koha branch you are looking for.
The value can be one of `master`, `stable`, or `oldstable`.

## Outputs

### `current-branch-name`

The current branch name that matches the given label.

For example, if today is Dec 19, 2019, and I ask for 'stable', I will get back '19.11.x'.
If I ask for 'oldstable' I will get '19.05.x'.
If I do that same thing in 6 months ( the release cycle length ), I will get back '20.05.x' and '19.11.x' respectively.

## Example usage

```yaml
- name: Get Koha Version Branch Name
  id: koha-version
  uses: "bywatersolutions/github-action-koha-get-version-by-label@master"
  with:
    release-version: 'stable'
```
