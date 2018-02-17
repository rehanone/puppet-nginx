#!/usr/bin/env bash

puppet epp render nginx.repo.epp --values '{ baseurl => "http://www.example.com"  }'