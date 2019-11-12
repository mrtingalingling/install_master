FROM continuumio/anaconda3
LABEL authors="Ting <ting.lik.2@gmail.com>"

WORKDIR /opt/notebooks

# This code snippet comes from:
# http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
# It prevents the jupyter kernels from crashing due to lack of PID reaping.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# This allows a handy autopep8 extension.
RUN pip install autopep8

# Create a samples directory with the samples (and library files).
RUN mkdir /opt/notebooks/samples
COPY samples/*.ipynb /opt/notebooks/samples/

EXPOSE 8888
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--port=8888", "--no-browser", "--ip=0.0.0.0"]