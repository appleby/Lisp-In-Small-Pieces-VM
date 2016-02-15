# Lisp-In-Small-Pieces-VM

## Public Service Announcement

**This is probably _not_ the repo you are looking for.**

**If you just want to run the scheme code for the book
[_Lisp In Small Pieces_][LiSP], have a look at
[appleby/Lisp-In-Small-Pieces][appleby-LiSP], instead.**

The README file for [appleby/Lisp-In-Small-Pieces][appleby-LiSP]
explains how to setup a virtual dev environment using the VMs created
here.

**If you just want an example of a packer template that builds an
Arch Linux system, have a look at
[elasticdog/packer-arch][packer-arch].**

This repo is derived from [elasticdog/packer-arch.][packer-arch].


## About this Repo

This repo contains a packer template that builds virtual machines
suitable for running the scheme code in the
[appleby/Lisp-In-Small-Pieces][appleby-LiSP] repo.

The packer build is run on Hashicorp's Atlas service, and the
artifacts produced are also hosted on Atlas. The artifacts produced by
this build are:

- a vagrant box for the vagrant virtualbox provider
- a vagrant box for the vagrant vmware provider
- a virtualbox-compatible ovf in tar.gz format
- a vmware-compatible ovf in tar.gz format


## For the Adventurous Soul

If, for some reason, you want to use these scripts to push your own
lisp-in-small-pieces-vm build to Atlas, here is what to do:

1. Set `ATLAS_USERNAME` and (optionally) `ATLAS_NAME` in
   `atlas_env.sh`.
2. Set and export `ATLAS_TOKEN` in your shell. See
   [HashiCorp's authentication docs][hashicorp-auth] for more info.
3. Make whatever changes you want to the build.
4. Run `./atlas_push.sh` to push the build configuration to Atlas.
5. Make sure the `ATLAS_USERNAME` and `ATLAS_NAME` env variables are
   also defined in the build configuration on Atlas. See
   [Hashicorp's packer build environment docs][hashicorp-build-env]
   for more info.
6. Queue the build in Atlas. If successful, it should produce the four
   artifact types mentioned above.

[appleby-LiSP]: https://github.com/appleby/Lisp-In-Small-Pieces
[LiSP]: http://pagesperso-systeme.lip6.fr/Christian.Queinnec/WWW/LiSP.html
[packer-arch]: https://github.com/elasticdog/packer-arch
[hashicorp-auth]: https://atlas.hashicorp.com/help/user-accounts/authentication
[hashicorp-build-env]: https://atlas.hashicorp.com/help/packer/builds/build-environment
