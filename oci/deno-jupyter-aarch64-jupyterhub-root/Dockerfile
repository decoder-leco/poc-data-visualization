# The exact same image, but the user running the notebook will be root
# ---------------
#
FROM decoderleco/py-deno-jupyter:0.0.1-alpha-aarch64-hub

USER root

RUN apt-get update -y && apt-get install -y bash sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
/etc/sudoers

RUN echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]