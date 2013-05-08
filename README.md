Description
===========

Installs and configures Symphony according to the instructions at https://github.com/symphonycms/symphony-2#readme. Does not set up a symphony CMS. You will need to do this manually by going to http://hostname/install/ (this URL may be different if you change the attribute values).

Requirements
============

Platform
--------

* Debian, Ubuntu

Tested on:

* Ubuntu 9.04, 9.10, 10.04

Cookbooks
---------

* mysql
* php
* apache2
* opensssl (uses library to generate secure passwords)
* libxslt

Attributes
==========



The random generation is handled with the secure_password method in the openssl cookbook which is a cryptographically secure random generator and not predictable like the random method in the ruby standard library.

Usage
=====

If a different version than the default is desired, download that version and get the SHA256 checksum (sha256sum on Linux systems), and set the version and checksum attributes.

Add the "symphony" recipe to your node's run list or role, or include the recipe in another cookbook.

Chef will install and configure mysql, php, and apache2.

The mysql::server recipe needs to come first, and contain an execute resource to install mysql privileges from the grants.sql template in this cookbook.

## Note about MySQL

This cookbook will decouple the mysql::server and be smart about detecting whether to use a local database or find a database server in the environment in a later version.

License and Author
==================

Author:: Tass Skoudros (tass@skystack.com)


Copyright:: 2010-2011, Skystack, Limited

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
