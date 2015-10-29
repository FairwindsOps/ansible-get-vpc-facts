Role Name
=========

Ansible role to set facts about a VPC.

Requirements
------------

* Ansible >= 2.0*. The edge, it bleeds. So much so that you'lll need to revert to 1.9.x for `ansible-galaxy install` to work.
* Note: Omnia will need to enforce AWS resource metadata strings such as security group names such that they conform to Ansible attribute names.  To avoid this issue, `tasks/security-groups.yml` replaces dashes (`-`) with underscores. Otherwise:

```
..."The variable name 'reactr-working_web' is not valid. Variables must start with a letter or underscore character, and contain only letters, numbers and underscores."...
```


Role Variables
--------------

These variables need to be set. In Omnia, in `default/account.yml`:

```
vpc_tag_name: 'reactr-vpc'
aws_region: 'us-east-1'
```

As a result, various facts are then set. Among them:

* The VPC ID:

```
{{aws_vpc_id}}
```

* Subnet IDs by name:

```
{{administration_primary}}
{{private_working_primary}}
```

* Security group IDs :

```
{{stg_presentation}}
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
    - get_facts

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

ReactiveOps