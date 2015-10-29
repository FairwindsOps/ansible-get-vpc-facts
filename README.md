Role Name
=========

Ansible role to set facts about a VPC.

Requirements
------------

*Ansible >= 2.0*. The edge, it bleeds. So much so that you'lll need to revert to 1.9.x for `ansible-galaxy install` to work.

Example Playbook
----------------

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
  roles:
    - get_facts

  tasks:

    - name: Ensure bastion sg
      ec2_group:
        state: present        
        name: "{{sg_bastion}}"
        description: "{{sg_bastion}}"
        vpc_id: "{{ aws_vpc_id }}"
        region: "{{ aws_region }}"
        rules:
          - proto: tcp
            from_port: 22
            to_port: 22
            cidr_ip: 0.0.0.0/0
      register: my_sg_bastion

    - name: Tag
      local_action:
        module: ec2_tag
        resource: "{{my_sg_bastion.group_id}}"
        region: "{{ aws_region }}"
        state: present
        tags:
          Name: "{{sg_bastion}}"


License
-------

TBD

Author Information
------------------

ReactiveOps