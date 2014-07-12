# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
DroughtMonitorApi::Application.config.secret_token = '7fbe03e96bf945b6e9419eedf60b4edc9d570bbbe845ec32662b2db06a2da36236c03a7c6655d2473b69c9d7ba832498123b960701e24e168647deb923be4f01'
