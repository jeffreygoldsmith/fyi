# typed: true
# frozen_string_literal: true

#
# Responses::BaseResponse
#
# Effect: a base response for all other responses to inherit from.
#         A response should be a service which communicates with the user through Slack.
#         The goal of the BaseResponse is to execute a given responses individual functionality
#         and handle any errors that are raised during that process. Should an error be raised,
#         the BaseResponse should attempt to communicate that to the user if possible.
#
module Responses
  class BaseResponse
    extend(T::Sig)
    extend(T::Helpers)
    abstract!

    sig { abstract.void }
    def respond; end

    sig { void }
    def call
      begin
        respond
      catch
      end
    end
  end
end
