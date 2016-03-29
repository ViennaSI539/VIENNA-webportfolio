#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
import webapp2
import os
import logging
import jinja2

# Lets set it up so we know where we stored the template files
JINJA_ENVIRONMENT = jinja2.Environment(
    loader=jinja2.FileSystemLoader(os.path.dirname(__file__)),
    extensions=['jinja2.ext.autoescape'],
    autoescape=True)

class MainHandler(webapp2.RequestHandler):
    def get(self):
       #if path == JINJA_ENVIRONMENT.get_template()
        #  nav1 = self.response.write('home')
        path = self.request.path #get which link the user pick in nav 
        if path == '/index.html' or path == '/':#'/' empty input
            template = JINJA_ENVIRONMENT.get_template('templates/index.html')
            self.response.write(template.render({'title': 'HOME'}))#dictionary:'key':'value'
        elif path == '/resume.html':
            template = JINJA_ENVIRONMENT.get_template('templates/resume.html')
            self.response.write(template.render({'title':'RESUME'}))
        elif path == '/contact.html':
            template = JINJA_ENVIRONMENT.get_template('templates/contact.html')
            self.response.write(template.render({'title':'CONTACT'}))
        elif path == '/login.html':
            template = JINJA_ENVIRONMENT.get_template('templates/login.html')
            self.response.write(template.render({'title':'LOGIN'}))


class LoginHandler(webapp2.RequestHandler):
    def get(self):
        template = JINJA_ENVIRONMENT.get_template('templates/login.html')
        self.response.write(template.render({'title': 'LOGIN'}))
    def post(self):
        name = self.request.get('name')
        pw = self.request.get('pw')
        
        logging.info('The Name the user types in is ' + name + ' and the PW the user types in is ' + pw)
        rightname = 'Colleen'
        rightpw = 'pass'
        if name == rightname and pw == rightpw :
            template = JINJA_ENVIRONMENT.get_template('templates/logged.html')
            self.response.write(template.render({'title':'LOGGED IN...'}))

        else :
            #logging.info-put the texts with time in log, logging.exception-put the texts with error in front.
            logging.exception('Bad credentials.')
            template = JINJA_ENVIRONMENT.get_template('templates/login.html')
            self.response.write(template.render({'title':'LOGIN','hint':'Bad credentials. Try again.'}))# tip is a variable that will show if the input is a wrong name/pw.
          


app = webapp2.WSGIApplication([
    ('/', MainHandler),#doc address,handler
    ('/index.html', MainHandler),
    ('/resume.html', MainHandler),
    ('/contact.html', MainHandler),
    ('/login.html', LoginHandler),
], debug=True)