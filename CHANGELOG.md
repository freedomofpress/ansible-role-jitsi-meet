# Change Log

## [v4.1.0](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v4.1.0)

Thanks to [@tabacha](https://github.com/tabacha):
  * Now can be used custom versions of all jinja templates changing a variable to indicate its path ([#22](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/22))

## [v4.0.0](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v4.0.0)

* Now isn't necessary add the prefix 'stun:' in `jitsi_meet_stun_servers` list

* Improved order and location of some tasks and variable names. Renamed:
  * `jitsi_meet_jigasi_jicofo_sip_template` -> `jitsi_meet_jicofo_sip_template`
  * `jitsi_meet_jigasi_videobridge_sip_template` -> `jitsi_meet_videobridge_sip_template`

* Jitsi Meet now enables statistics and uses "muc" transport. On *defaults/main.yml*:
  * `jitsi_meet_videobridge_statistics_enable: false` changed to `jitsi_meet_videobridge_statistics_enable: true`
  * `jitsi_meet_videobridge_statistics_interval: 5000` changed to `jitsi_meet_videobridge_statistics_interval: 1000`
  * `jitsi_meet_videobridge_statistics_transport: 'colibri,xmpp'` changed to `jitsi_meet_videobridge_statistics_transport: 'muc'`
  * `jitsi_meet_videobridge_opts: '--apis=rest,'` changed to `jitsi_meet_videobridge_opts: '--apis=,'`

* Fixed [#16](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/issues/16): Now, the instance's `MUC_NICKNAME` is registered in a variable and isn't overwritten when using the videobridge configuration jinja template.
  It's also possible to connect the videobridge to other XMPP servers and enable [Multi-user chat mode](https://github.com/jitsi/jitsi-videobridge/blob/master/doc/muc.md) through the variable `jitsi_meet_videobridge_other_xmpp_servers` (dictionary type).

Thanks to [@tabacha](https://github.com/tabacha):

  * Change all variable name to the positive meaning ([#15](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/issues/15)) ([#17](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/17))
    * `jitsi_meet_disable_third_party_requests` -> `jitsi_meet_enable_third_party_requests`
    * `jitsi_meet_desktop_sharing_chrome_disabled` -> `jitsi_meet_enable_desktop_sharing_chrome`
    * `jitsi_meet_desktop_sharing_firefox_disabled` -> `jitsi_meet_enable_desktop_sharing_firefox`
    * `jitsi_meet_disable_video_background` -> `jitsi_meet_show_video_background`
    * `jitsi_meet_disable_audio_levels` -> `jitsi_meet_show_audio_levels`

  * Now all variables are real boolean. Before this release, were of the string type the variables:
    * `jitsi_meet_desktop_sharing_chrome_disabled`
    * `jitsi_meet_desktop_sharing_firefox_disabled`
    * `jitsi_meet_disable_video_background`
    * `jitsi_meet_generate_roomnames_on_welcome_page`

  * Performance optimizations possible through variables: ([#14](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/14))
    * Change the screen resolution
    * Start with audio only
    * Show only a few last speaker, not all
    * No audio Level Display
    * Layer suspension

## [v3.0.1](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v3.0.1)

Thanks to [@tabacha](https://github.com/tabacha):
  * Fixed the settings that were static in `templates/videobridge_sip-communicator.properties.j2` ([#13](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/13))

## [v3.0.0](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v3.0.0)

* **`jitsi_meet_install_recommends: no` changed to `jitsi_meet_install_recommends: yes` on *defaults/main.yml*** (See [PR #5729](https://github.com/jitsi/jitsi-meet/pull/5729))
* **`jitsi_meet_configure_firewall: true` changed to `jitsi_meet_configure_firewall: false` on *defaults/main.yml***. To avoid overlapping with the rest of your roles/playbooks and lose SSH access. (This role focuses on configuring Jitsi Meet)
* Manage videobridge stats and colibri exposure over HTTPS
* Thanks to [@tabacha](https://github.com/tabacha):
    * `jitsi_meet_disable_third_party_requests` used correctly ([#10](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/10))
    * UFW ports configurable from vars ([#11](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/11))
      **Note that now enabling SSH port isn't part of the default behavior**
    * Manage Prosody authentication ([#12](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/12))
* Thanks to [@fabiogermann](https://github.com/fabiogermann):
    * Settings to run behind a NAT firewall ([#7](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/pull/7))
* Added Ansible tags for each component in *tasks/main.yml*
* Various improvements in code quality

## [v2.0.0](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v2.0.0)

### Second version of the role, designed for Jitsi Meet v2.X

* Default Nginx web server, custom settings are maintained from a variable (`jitsi_meet_configure_nginx`).

* Now the installation of `jitsi-meet` from apt recommends the installation of a turnserver, a feature that can cause various problems with nginx configurations. Added `jitsi_meet_install_recommends` variable to influence this behavior.

* Using `present` instead `latest` when installing packages.

* Various improvements and simplifications of tasks that are no longer necessary.

## [v1.0.0](https://github.com/UdelaRInterior/ansible-role-jitsi-meet/tree/v1.0.0)

### First version of the role, designed for Jitsi Meet v1.X

* Jetty default web server, with option to install and configure Nginx from a variable.
