/* eslint no-console:0 */

import { Application } from "stimulus"
require("@rails/ujs").start()
require("turbolinks").start()
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))

import "../stylesheets/application.css"

