FROM centos:7

USER root

# OS Update First
RUN yum -y update
RUN yum -y install ansible
RUN yum -y install openssh-clients.x86_64

# Ansible User
RUN adduser -ms /bin/bash ansible
RUN mkdir /home/ansible/.ssh
COPY ssh/* /home/ansible/.ssh/

# Ansible Config
COPY etc-ansible/hosts /etc/ansible/
COPY etc-ansible/ansible.cfg /etc/ansible/

# Ansible Playbooks
RUN mkdir -p /etc/ansible/roles/common/tasks
COPY playbooks/* /etc/ansible/roles/common/tasks/

USER ansible
