<!-- README.md -->
# clean.skel
#### An /etc/skel directory for \*nix sysadmins and enthusiasts.
clean.skel is a project that aims to clean the clutter of hidden files in our home directories by giving them meaningful non-hidden and desktop environment agnostic paths.
## Home Directory Hierarchy
Inspired by the Linux Filesystem Hierarchy, we've created our own Home Directory Hierarchy.  It provides memorable three-letter base paths modeled after the \*nix top-level directories making it easy to specify them on the command line or elsewhere in just a few keystrokes.
* [aud](skel/aud) &ndash; audio files.
* [aud/music](skel/aud/music) &ndash; music.
* [bin](skel/bin) &ndash; executable files (included in `PATH`).
* [doc](skel/doc) &ndash; documents and documentation files.
* [dsk](skel/dsk) &ndash; desktop.
* [dwn](skel/dwn) &ndash; internet download destination.
* [etc](skel/etc) &ndash; configuration files.
* [img](skel/img) &ndash; photographs and other images.
* [mnt](skel/mnt) &ndash; users mounted volumes.
* [vid](skel/vid) &ndash; video files.
* [pkg](skel/pkg) &ndash; custom and third-party software and documentation packages.
* [pub](skel/pub) &ndash; public (shared) files.
* [src](skel/src) &ndash; source files for software development and design projects.
* [tpl](skel/tpl) &ndash; file templates.
* [var](skel/var) &ndash; files that are modified frequently by applications just doing their normal duties.
* [var/cache](skel/var/cache) &ndash; cache files.
* [var/lib](skel/var/lib) &ndash; permanent files.
* [var/mail](skel/var/mail) &ndash; Maildir/qmail directory.
* [var/run](skel/var/run) &ndash; temporary files.
## Strategies
It is an *upstream* battle, as there are no strong conventions and project developers can and will put their application's files anywhere and everywhere.  Fortunately, there are some solutions.
* `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, and `XDG_CACHE_HOME` environment variables are a standardized way to specify the base directory for config, data, and cache files in the (unfortunately few) complying applications.
* `~/.config`, `~/.local`, and `~/.cache` are standard base directories for config, data, and cache files which serve as the default for the above-mentioned environment variables.  May applications which do not conform to the XDG environment variables still use these directories.
* A host of application-specific environment variables can also be used to pursued applications to use specific base directories for their files.
* Aliasing command-line programs to use arguments that change where they look for config files and whatnot.
* If all else fails, most applications just call `open` and don't consider whether there is a symbolic link in the path, this allows us to trick applications that just don't want to change their behavior to comply to our Home Directory Hierarchy.
* Very few applications can't or simply won't use anything but hidden files in the home directory, there is very little we can do about it (short of patching those applications), so we accept them and move on with our lives.
## Tweaking
Not all the decisions we made here are for you, fortunately, we've tried to make it as flexible as possible!  You can change the location of most things by modifying [pam\_env.conf](skel/etc/security/pam_env.conf), this is also the preferred way to set your default `EDITOR`, `PAGER`, `BROWSER`, etc..  You'll also have to change many the symbolic links in your home directory, which you will probably want to script (don't forget to submit your script, we want it!).  Don't forget to logout and login after changing [pam\_env.conf](skel/etc/security/pam_env.conf).
## Deploying
### If you're the local system administrator ...
... you can simply backup and remove your current `/etc/skel`, and copy our [skeleton directory](skel) to `/etc/skel` (don't forget to use the `-a` flag with `cp` to preserve the permissions!).  Now every time you create a new user they will inherit this skeleton directory.  *Note*: root should never use this skeleton directory for their home!  The settings in [pam\_env.conf](skel/etc/security/pam_env.conf) can have undesired effects.
### If you don't have access to root ...
... you can copy the contents of our skeleton directory right into your newly created home.  Converting an existing home directory is a bit trickier and can't easily be automated, but can be done manually if you know your way around it.
### In either case ...
... don't forget to remove all `.gitkeep` files used to convince git to hold otherwise empty directories: `find -type f -name .gitkeep -delete`
## Limitations
There certainly are limitations, to name a few:
* Not every application can be or is supported, and most new applications will require an addendum to this project.
* Some distributions ignore `~/.pam_environment` or don't use PAM at all.  It is important that the environment variables set in `~/.pam_environment` set in every application when you first log in; in particular, your desktop session manager.  As such, simply defining them in your shell's profile just isn't good enough.
* You may have to change the `HOME` variable in `~/.pam_environment` to reflect your literal home directory (ex. `/home/alice`) if you're using older versions of PAM.
* Your home directory will still be populated with many hidden symbolic links, as unfortunate as this is all we recommend is skipping the `-a` or `-A` flag to `ls` and not setting "show hidden files" in your file manager/explorer.
## Contributing
We would love to see you fixes and hear your suggestions.  We can use help expanding the supported applications or find workarounds for those stubborn applications which just don't seem to want to play nice with our [strategies](README.md#strategies).  We also would like to include support for shells beside POSIX shell, bash, and zsh.  **However**, the best thing you could do is fix the applications that don't conform to the XDG specification.  This project is mealy a stop-gap measure to work around applications that don't listen to the XDG environment variables, the real solution is for applications to use them.  We hope this project will not be needed in 5 years, but in the meantime, feel free to create an issue or submit a pull request.  For all non-trivial contributions to this project, we would like&mdash;but do not demand&mdash;you sign the [WAIVER](WAIVER) and add it to the [AUTHORS](AUTHORS) file like so: `echo -e "Your Name Here <you@email.domain>\n" | cat - WAIVER | gpg --clear-sign >> AUTHORS`
## Licensing
Most of the content in this project really isn't copyrightable material.  But, just to be sure:
* The software portion of this project ([bash.bashrc](skel/etc/bash.bashrc), [zsh.zshrc](skel/etc/zsh.zshrc), [profile](skel/etc/profile), ...) is released into the public domain, see [UNLICENSE](UNLICENSE) for details.
* The directory structure, symbolic links, and the configuration files [pam\_env.conf](skel/etc/security/pam_env.conf) and [npmrc](skel/etc/npm/npmrc), as well as the empty and functionally-empty configuration files, are also released into the public domain, see [CC0](CC0) for details.
* The configuration files [.screenrc](skel/.screenrc) and [default.pa](skel/etc/pulse/default.pa) should be treated as part of the [GNU Screen](https://www.gnu.org/software/screen/) and [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) software, see [GPL](GPL) for details.
* The configuration files [Xmodmap](skel/etc/X11/xinit/Xmodmap) and [Xresources](skel/etc/X11/xinit/Xresources) should be treated as part of the [X.Org](https://www.x.org/wiki/) software, see [XORG](XORG) for details
<!-- vim: set ts=2 sw=2 et syn=markdown -->
