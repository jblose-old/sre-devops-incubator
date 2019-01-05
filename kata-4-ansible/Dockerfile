FROM centos:7

USER root

RUN yum update
RUN yum -y install ansible

COPY etc-ansible/hosts /etc/ansible/
COPY etc-ansible/ansible.cfg /etc/ansible/

RUN mkdir -p /etc/ansible/roles/common/tasks
COPY playbooks/* /etc/ansible/roles/common/tasks/