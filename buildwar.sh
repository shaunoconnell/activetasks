#!/bin/bash
(RAILS_ENV=development rake assets:precompile && RAILS_ENV=development warble)
