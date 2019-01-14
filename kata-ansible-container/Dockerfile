FROM centos:7

USER root

RUN adduser -ms /bin/bash jblose
RUN mkdir /home/jblose/.ssh
COPY ssh/* /home/jblose/.ssh/

RUN yum update
RUN yum -y install ansible
RUN yum -y install openssh-clients.x86_64

COPY etc-ansible/hosts /etc/ansible/
COPY etc-ansible/ansible.cfg /etc/ansible/

RUN mkdir -p /etc/ansible/roles/common/tasks
COPY playbooks/* /etc/ansible/roles/common/tasks/

USER jblose