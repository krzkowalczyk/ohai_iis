name 'ohai_iis'
maintainer 'Krzysztof Kowalczyk'
maintainer_email 'krz.kowalczyk@gmail.com'
license          'Apache-2.0'
description 'Installs/Configures ohai_iis'
long_description 'Installs/Configures ohai_iis'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/krzkowalczyk/ohai_iis/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/krzkowalczyk/ohai_iis'

depends 'ohai'
depends 'chef-client'

supports 'windows'
