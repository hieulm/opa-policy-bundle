
package httpapi.authz

# subordinates = {"alice": [], "charlie": [], "bob": ["alice"], "betty": ["charlie"]}

import data.companies

default allow = false

allow {
    http_api.path = ["product", "company", company_id]
    http_input.method = "GET"
}

# HTTP API request
import input as http_api
# http_api = {
#   "path": ["finance", "salary", "alice"],
#   "user": "alice",
#   "method": "GET"
# }

allow {
    http_api.path = ["products", "company", company_id]
    http_api.method  = "POST"
    http_api.user.company_id == company_id
    http_api.user.role == "admin"
}

# Allow users to get their own salaries.
# allow {
#   http_api.method = "GET"
#   http_api.path = ["finance", "salary", username]
#   username = http_api.user
# }

# # Allow managers to get their subordinates' salaries.
# allow {
#   http_api.method = "GET"
#   http_api.path = ["finance", "salary", username]
#   subordinates[http_api.user][_] = username
# }