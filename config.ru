require_relative './config/env'

use Rack::MethodOverride
use SessionsController
# use RunsController
run ApplicationController