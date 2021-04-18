FROM python:3.8-slim

WORKDIR /home

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && git clone https://github.com/emilkholod/OdooLocust.git /home/odoo \
    && && apt-get remove -yq git \
    && apt-get -yq autoremove --purge \
    && rm -Rf ~/.{cache,npm,gem} /var/lib/{apt/lists/*,gems/*/cache} /tmp/*

WORKDIR /home/odoo

RUN pip install -r requirements.txt \
    && python setup.py build \
    && python setup.py install \
    && rm -Rf ~/.{cache,npm,gem} /var/lib/{apt/lists/*,gems/*/cache} /tmp/*

ADD ./tests/ /home/odoo/OdooLocust/tests/

WORKDIR /home/odoo/OdooLocust/tests/

CMD ["locust", "-f", "Manager.py", "Manager"]
