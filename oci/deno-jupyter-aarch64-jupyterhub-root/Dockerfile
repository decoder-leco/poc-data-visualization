# The exact same image, but the user running the notebook will be root
# ---------------
#
FROM decoderleco/py-deno-jupyter:0.0.1-alpha-aarch64-hub

USER root

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]