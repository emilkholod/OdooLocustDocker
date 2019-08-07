FROM python:3.6.9-buster

RUN apt-get update && apt-get install -y --no-install-recommends git

WORKDIR /home
RUN git clone https://github.com/niulinlnc/OdooLocust.git /home/odoo

WORKDIR /home/odoo
RUN pip install -r requirements.txt && \
    python setup.py build && \
    python setup.py install

ADD ./tests/ /home/odoo/OdooLocust/tests/

WORKDIR /home/odoo/OdooLocust/tests/

EXPOSE 8089

CMD ["locust", "-f", "Manager.py", "Manager"]
