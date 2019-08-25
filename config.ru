require_relative './config/env'

use Rack::MethodOverride
use SessionController
use RunsController
use UsersController
run ApplicationController