# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.media_src  :none
  policy.child_src  :none
  policy.script_src  :self, :https
  # "'sha256-3mlDP3A+P+hdKPAid+jW62qRYTvpMHzuF9P6yaNmNWA='"
  policy.style_src   :https, :self, "'unsafe-inline' *.tinymce.com *.tiny.cloud"
          # "'sha256-jOcXrl7xWI3Tql0uEvwjR0w/IIaMXrn5N9kNTiNqFV4='", 
          # "'sha256-KLWCe8hxQPIWsPXiFLOcshBdEkHZkGJ5a0rQRi6vLp0='", 
          # "'sha256-BI/U+Yjkb3heIAGFzBocOAQPRBlBbhRKLLQzVYoA5KQ='",
          
#   # If you are using webpack-dev-server then specify webpack-dev-server host
  policy.connect_src :self, :https, "http://10.50.55.30:3000", "ws://10.50.55.30:3000" if Rails.env.development?
  policy.frame_ancestors :none
#   # Specify URI for violation reports
  # policy.report_uri "/csp-violation-report-endpoint"
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
Rails.application.config.content_security_policy_report_only = true
