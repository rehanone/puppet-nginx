#!/usr/bin/env bash

puppet epp render nginx.conf.epp --values '{ install_location => "/etc/nginx"  }'
