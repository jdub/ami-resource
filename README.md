# AMI Update Resource

A Concourse CI resource to check for new Amazon Machine Images (AMI).

### Source Configuration

- `aws_access_key_id` *Required.* Your AWS access key ID.

- `aws_secret_access_key` *Required.* Your AWS secret access key.

- `region` *Required.* The AWS region to search for AMIs.

- `filters` *Required.* A map of named filters to their values. See `aws ec2 describe-images help` under `--filters` for acceptable filters and values.

### Example

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
