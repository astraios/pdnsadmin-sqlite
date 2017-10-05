FROM centos

# Update the distribution
RUN yum update -y

# Install epel-release
RUN yum install epel-release -y

# Install the required packages
RUN yum install -y python-pip \
                   gcc \
                   python-devel \
                   openldap-devel \
                   mysql-devel
RUN yum install -y git

# Upgrade pip
RUN pip install --upgrade pip
#RUN LC_ALL=C pip install mysql-python

# Install virtualenv
RUN pip install virtualenv

# Clean yum cache
RUN yum clean all

# Install PDNS from git
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/ngoduykhanh/PowerDNS-Admin.git
RUN mv PowerDNS-Admin pdnsadmin

# Compile pdnsadmin and its dependancies
WORKDIR /data/pdnsadmin
#RUN echo >> requirements.txt
#RUN echo "mysql-python==1.2.3" >> requirements.txt
#RUN echo requirements.txt

RUN virtualenv flask
RUN source ./flask/bin/activate && pip install -r requirements.txt
# Copy additional files
COPY config_template.py config_template.py
COPY entrypoint.sh entrypoint.sh

VOLUME /powerdns-admin

EXPOSE 9393/tcp
ENTRYPOINT ["/data/pdnsadmin/entrypoint.sh"]
CMD ["bash"]

