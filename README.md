Role Name
=========

Ansible role to set facts about a VPC.

Requirements
------------

* **Ansible >= 2.0**. The edge, it bleeds. Place this in ansible-requirements.yml

```
- src: git+ssh://git@github.com/FairwindsOps/ansible-get-vpc-facts
  name: fairwinds.get-vpc-facts-master
  path: ~/.omnia/roles
  scm: git
```

* Note: Ansible requires that variables contain only letters, numbers and underscores. Because of this, `-`, `.`, and ` ` are converted to `_` in subnets and security groups names.


```
..."The variable name 'reactr-working_web' is not valid. Variables must start with a letter or underscore character, and contain only letters, numbers and underscores."...
```


Role Variables
--------------

These variables need to be set. In Omnia, in `default/account/vars.yml`:

```
vpc_tag_name: 'reactr-vpc'
```

As a result, various facts are then set. Among them:

* The VPC ID:

```
{{aws_vpc_id}}
{{aws_vpc_cidr}}
```

* Subnet IDs by name:

```
{{public_az1}}
{{private_prod_az1}}
{{private_working_az1}}
...
```

* Security group IDs :

```
{{dev_presentation}}
{{prod_presentation}}
{{dev_application}}
{{prod_application}}
{{dev_data}}
{{prod_data}}
```

Example Playbook
----------------
* In order to create a security group, you'll need the VPC ID. By including this role, you'll have access to it.

```
- name: Security Groups
  hosts: localhost
  connection: local
  gather_facts: False

  pre_tasks:
    - include_vars: ../../account.yml
      tags:
        always
    - include_vars: ./env.yml
      tags:
        always
###
# Include the role in a pre_task
###
  roles:
    - fairwinds.get-vpc-facts

###
# {{ aws_vpc_id }} is now set:
##

  tasks:

    - name: Ensure bastion sg
      ec2_group:
        state: present
        name: "{{sg_bastion}}"
        description: "{{sg_bastion}}"
        vpc_id: "{{ aws_vpc_id }}"
        region: "{{ aws_region }}"
      register: my_sg_bastion

...
```

License
-------

TBD

Author Information
------------------

Fairwinds
