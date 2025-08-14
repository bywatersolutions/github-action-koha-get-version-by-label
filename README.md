# Koha Branch by Label

This action returns the current Koha branch name for a given version label.

## Inputs

### `version-label`

**Required** Label of the Koha branch you are looking for.
The value can be one of `main`, `stable`, or `oldstable`.

## Outputs

### `current-branch-name`

The current branch name that matches the given label.

For example:
- `main` → `main`
- `stable` → `25.05.x` (current stable branch)
- `oldstable` → `24.11.x` (previous stable branch)

The actual version numbers change with each Koha release cycle (every 6 months).

### `branch-name`

Same as `current-branch-name`

### `version-major-minor`

Major and minor version of Koha for versioned branches, e.g. `25.05`
(Empty for `main` branch)

### `version-major`

Major version of Koha for versioned branches, e.g. `25`
(Empty for `main` branch)

### `version-minor`

Minor version of Koha for versioned branches, e.g. `05`
(Empty for `main` branch)

## Example usage

```yaml
- name: Get Koha Version Branch Name
  id: koha-version
  uses: "bywatersolutions/github-action-koha-get-version-by-label@v2"
  with:
    version-label: 'stable'

- name: Use the branch name
  run: |
    echo "Koha stable branch is ${{ steps.koha-version.outputs.current-branch-name }}"
    echo "Version is ${{ steps.koha-version.outputs.version-major-minor }}"
    
- name: Checkout Koha at stable version
  uses: actions/checkout@v4
  with:
    repository: 'Koha-Community/Koha'
    ref: ${{ steps.koha-version.outputs.current-branch-name }}
```

## Changelog

### v2.0.0
- **BREAKING**: Requires GitHub Actions runner with `$GITHUB_OUTPUT` support
- Fixed deprecated `::set-output` syntax, now uses modern `$GITHUB_OUTPUT`
- Updated README example to use correct parameter name (`version-label` not `release-version`)
- Improved examples with realistic Koha branch names and version numbers
- Added comprehensive test workflow

### v1.0.0
- Initial release with support for `main`, `stable`, and `oldstable` labels
- Multiple output formats for version information
