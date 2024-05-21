# The `TypeScript` Jupyterhub notebook

## Why

I designed a jupyter notebook container image, for ARM v8 `aarch64` cpu architecture, this image purpose is to be as simple as possible, from the ["singleuser-sameple" default jupyterhub image](ccc), adding just enough to add the deno kernel.

## Errors stack

### first error i got 

```bash
ubuntu@DecoderLecoCadeauBOB:~$ kubectl -n decoderleco logs pod/jupyter-pierre
Defaulted container "notebook" out of: notebook, block-cloud-metadata (init)
[W 2024-05-21 20:49:18.922 ServerApp] Unrecognized alias: 'unstable', it will have no effect.
WARNING: Insecure writes have been enabled via environment variable 'JUPYTER_ALLOW_INSECURE_WRITES'! If this is not intended, remove the variable or set its value to 'False'.
[W 2024-05-21 20:49:19.076 ServerApp] A `_jupyter_server_extension_points` function was not found in nbclassic. Instead, a `_jupyter_server_extension_paths` function was found and will be used for now. This function name will be deprecated in future releases of Jupyter Server.
[I 2024-05-21 20:49:19.078 ServerApp] jupyter_lsp | extension was successfully linked.
[I 2024-05-21 20:49:19.082 ServerApp] jupyter_server_terminals | extension was successfully linked.
[I 2024-05-21 20:49:19.082 JupyterHubSingleUser] Starting jupyterhub single-user server extension version 5.0.0b2
[I 2024-05-21 20:49:19.082 JupyterHubSingleUser] Using default url from server extension lab: /lab
[I 2024-05-21 20:49:19.085 ServerApp] jupyterhub | extension was successfully linked.
[W 2024-05-21 20:49:19.086 LabApp] 'extra_template_paths' was found in both NotebookApp and ServerApp. This is likely a recent change. This config will only be set in NotebookApp. Please check if you should also config these traits in ServerApp for your purpose.
[I 2024-05-21 20:49:19.089 ServerApp] jupyterlab | extension was successfully linked.
[W 2024-05-21 20:49:19.090 NotebookApp] 'extra_template_paths' was found in both NotebookApp and ServerApp. This is likely a recent change. This config will only be set in NotebookApp. Please check if you should also config these traits in ServerApp for your purpose.
[I 2024-05-21 20:49:19.092 ServerApp] nbclassic | extension was successfully linked.
[I 2024-05-21 20:49:19.092 ServerApp] nbgitpuller | extension was successfully linked.
[W 2024-05-21 20:49:19.092 ServerApp] notebook_shim | error linking extension: [Errno 13] Permission denied: '/home/jovyan/.local/share/jupyter/runtime'
    Traceback (most recent call last):
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 632, in get
        value = obj._trait_values[self.name]
                ~~~~~~~~~~~~~~~~~^^^^^^^^^^^
    KeyError: 'browser_open_file'

    During handling of the above exception, another exception occurred:

    Traceback (most recent call last):
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 632, in get
        value = obj._trait_values[self.name]
                ~~~~~~~~~~~~~~~~~^^^^^^^^^^^
    KeyError: 'runtime_dir'

    During handling of the above exception, another exception occurred:

    Traceback (most recent call last):
      File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/manager.py", line 346, in link_extension
        extension.link_all_points(self.serverapp)
      File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/manager.py", line 228, in link_all_points
        self.link_point(point_name, serverapp)
      File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/manager.py", line 218, in link_point
        point.link(serverapp)
      File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/manager.py", line 140, in link
        linker(serverapp)
      File "/usr/local/lib/python3.11/site-packages/notebook_shim/nbserver.py", line 109, in _link_jupyter_server_extension
        members = diff_members(serverapp, nbapp)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/notebook_shim/nbserver.py", line 62, in diff_members
        m1 = public_members(obj1)
             ^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/notebook_shim/nbserver.py", line 56, in public_members
        members = inspect.getmembers(obj)
                  ^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/inspect.py", line 595, in getmembers
        return _getmembers(object, predicate, getattr)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/inspect.py", line 573, in _getmembers
        value = getter(object, key)
                ^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 687, in __get__
        return t.cast(G, self.get(obj, cls))  # the G should encode the Optional
                         ^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 635, in get
        default = obj.trait_defaults(self.name)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 1897, in trait_defaults
        return t.cast(Sentinel, self._get_trait_default_generator(names[0])(self))
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 1241, in __call__
        return self.func(*args, **kwargs)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/jupyter_server/serverapp.py", line 1755, in _default_browser_open_file
        return os.path.join(self.runtime_dir, basename)
                            ^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 687, in __get__
        return t.cast(G, self.get(obj, cls))  # the G should encode the Optional
                         ^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 635, in get
        default = obj.trait_defaults(self.name)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 1897, in trait_defaults
        return t.cast(Sentinel, self._get_trait_default_generator(names[0])(self))
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/usr/local/lib/python3.11/site-packages/jupyter_core/application.py", line 111, in _runtime_dir_default
        ensure_dir_exists(rd, mode=0o700)
      File "/usr/local/lib/python3.11/site-packages/jupyter_core/utils/__init__.py", line 26, in ensure_dir_exists
        Path(path).mkdir(parents=True, mode=mode)
      File "/usr/local/lib/python3.11/pathlib.py", line 1116, in mkdir
        os.mkdir(self, mode)
    PermissionError: [Errno 13] Permission denied: '/home/jovyan/.local/share/jupyter/runtime'
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 632, in get
    value = obj._trait_values[self.name]
            ~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 'runtime_dir'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/jupyterhub-singleuser", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/application.py", line 616, in launch_instance
    serverapp = cls.initialize_server(argv=args)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/jupyter_server/extension/application.py", line 586, in initialize_server
    serverapp.initialize(
  File "/usr/local/lib/python3.11/site-packages/traitlets/config/application.py", line 118, in inner
    return method(app, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/jupyter_server/serverapp.py", line 2754, in initialize
    self.init_configurables()
  File "/usr/local/lib/python3.11/site-packages/jupyter_server/serverapp.py", line 2064, in init_configurables
    "connection_dir": self.runtime_dir,
                      ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 687, in __get__
    return t.cast(G, self.get(obj, cls))  # the G should encode the Optional
                     ^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 635, in get
    default = obj.trait_defaults(self.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/traitlets/traitlets.py", line 1897, in trait_defaults
    return t.cast(Sentinel, self._get_trait_default_generator(names[0])(self))
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/jupyter_core/application.py", line 111, in _runtime_dir_default
    ensure_dir_exists(rd, mode=0o700)
  File "/usr/local/lib/python3.11/site-packages/jupyter_core/utils/__init__.py", line 26, in ensure_dir_exists
    Path(path).mkdir(parents=True, mode=mode)
  File "/usr/local/lib/python3.11/pathlib.py", line 1116, in mkdir
    os.mkdir(self, mode)
PermissionError: [Errno 13] Permission denied: '/home/jovyan/.local/share/jupyter/runtime'

```

## The Jupyterhub default image

* [Its `Dockerfile`](https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/main/images/singleuser-sample/Dockerfile)

* What i need to also have in my image:
  * the creation of the user $NB_USER
  * the 
