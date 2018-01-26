# AMI Update Resource

A Concourse CI resource to check for new Amazon Machine Images (AMI).

## Source Configuration

If you want to assume a role and lookup an AMI in another account, use:

- `role_id`: Your AWS role to assume. Make sure concourse can assume this role.

- `account_id`: The AWS account ID where you want to look up the AMI.

Note: both needs to be set.

Else, use:

- `aws_access_key_id`: Your AWS access key ID.

- `aws_secret_access_key`: Your AWS secret access key. 

- `region`: *Required.* The AWS region to search for AMIs.

- `filters`: *Required.* A map of named filters to their values. Check the AWS CLI [describe-images](http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html) documentation for a complete list of acceptable filters and values.

If `aws_access_key_id` and `aws_secret_access_key` are both absent, AWS CLI will fall back to other authentication mechanisms. See [Configuration setting and precedence](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence)

## Behaviour

### `check`: Check for new AMIs

Searches for AMIs that match the provided source filters, ordered by their creation date. The AMI ID serves as the resulting version.

#### Parameters

*None.*

### `in`: Fetch the description of an AMI

Places the following files in the destination:

- `output.json`: The complete AMI description object in JSON format. Check the AWS CLI [describe-images](http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html#examples) documentation for examples.

- `id`: A plain text file containing the AMI ID, e.g. `ami-5731123e`

- `packer.json`: The AMI ID in Packer `var-file` input format, typically for use with [packer-resource](https://github.com/jdub/packer-resource), e.g.

  ```json
  {"source_ami": "ami-5731123e"}
  ```

#### Parameters

*None.*

## Example

This pipeline will check for a new Ubuntu 14.04 LTS AMI in the Sydney region every hour, triggering the next step of the build plan if it finds one.

```yaml
resource_types:
- name: ami
  type: docker-image
  source:
    repository: jdub/ami-resource

resources:
- name: ubuntu-ami
  type: ami
  check_every: 1h
  source:
    aws_access_key_id: "..."
    aws_secret_access_key: "..."
    region: ap-southeast-2
    filters:
      owner-id: "099720109477"
      is-public: true
      state: available
      name: ubuntu/images/hvm-ssd/ubuntu-trusty-*server*

jobs:
- name: my-ami
  plan:
  - get: ubuntu-ami
    trigger: true
  - task: build-fresh-image
    ...
```
