# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `actionmailer` gem.
# Please instead update this file by running `tapioca generate`.

# typed: true

module ActionMailer
  extend(::ActiveSupport::Autoload)

  class << self
    def eager_load!; end
    def gem_version; end
    def version; end
  end
end

class ActionMailer::Base < ::AbstractController::Base
  include(::ActionMailer::DeliveryMethods)
  include(::ActiveSupport::Rescuable)
  include(::ActionMailer::Rescuable)
  include(::ActionMailer::Parameterized)
  include(::ActionMailer::Previews)
  include(::ActionView::ViewPaths)
  include(::AbstractController::Rendering)
  include(::AbstractController::Logger)
  include(::ActiveSupport::Benchmarkable)
  include(::AbstractController::Helpers)
  include(::AbstractController::Translation)
  include(::AbstractController::AssetPaths)
  include(::ActiveSupport::Callbacks)
  include(::AbstractController::Callbacks)
  include(::AbstractController::Caching::Fragments)
  include(::AbstractController::Caching::ConfigMethods)
  include(::AbstractController::Caching)
  include(::ActionView::Rendering)
  include(::ActionView::Layouts)
  extend(::ActionMailer::DeliveryMethods::ClassMethods)
  extend(::ActiveSupport::Rescuable::ClassMethods)
  extend(::ActionMailer::Rescuable::ClassMethods)
  extend(::ActionMailer::Parameterized::ClassMethods)
  extend(::ActionMailer::Previews::ClassMethods)
  extend(::ActionView::ViewPaths::ClassMethods)
  extend(::AbstractController::Helpers::ClassMethods)
  extend(::ActiveSupport::Callbacks::ClassMethods)
  extend(::AbstractController::Callbacks::ClassMethods)
  extend(::AbstractController::Caching::Fragments::ClassMethods)
  extend(::AbstractController::Caching::ClassMethods)
  extend(::AbstractController::Caching::ConfigMethods)
  extend(::ActionView::Rendering::ClassMethods)
  extend(::ActionView::Layouts::ClassMethods)

  def initialize; end

  def __callbacks; end
  def __callbacks?; end
  def _helper_methods; end
  def _helper_methods=(_arg0); end
  def _helper_methods?; end
  def _process_action_callbacks; end
  def _run_process_action_callbacks(&block); end
  def _view_cache_dependencies; end
  def _view_cache_dependencies=(_arg0); end
  def _view_cache_dependencies?; end
  def asset_host; end
  def asset_host=(value); end
  def assets_dir; end
  def assets_dir=(value); end
  def attachments; end
  def default_asset_host_protocol; end
  def default_asset_host_protocol=(value); end
  def default_params; end
  def default_params=(_arg0); end
  def default_params?; end
  def default_static_extension; end
  def default_static_extension=(value); end
  def deliver_later_queue_name; end
  def deliver_later_queue_name=(val); end
  def delivery_job; end
  def delivery_job=(_arg0); end
  def delivery_job?; end
  def delivery_method; end
  def delivery_method=(_arg0); end
  def delivery_method?; end
  def delivery_methods; end
  def delivery_methods=(_arg0); end
  def delivery_methods?; end
  def email_address_with_name(address, name); end
  def enable_fragment_cache_logging; end
  def enable_fragment_cache_logging=(value); end
  def file_settings; end
  def file_settings=(_arg0); end
  def file_settings?; end
  def fragment_cache_keys; end
  def fragment_cache_keys=(_arg0); end
  def fragment_cache_keys?; end
  def headers(args = T.unsafe(nil)); end
  def javascripts_dir; end
  def javascripts_dir=(value); end
  def logger; end
  def logger=(value); end
  def mail(headers = T.unsafe(nil), &block); end
  def mailer_name; end
  def message; end
  def message=(_arg0); end
  def params; end
  def params=(_arg0); end
  def perform_caching; end
  def perform_caching=(value); end
  def perform_deliveries; end
  def perform_deliveries=(val); end
  def preview_interceptors; end
  def preview_path; end
  def process(method_name, *args); end
  def raise_delivery_errors; end
  def raise_delivery_errors=(val); end
  def relative_url_root; end
  def relative_url_root=(value); end
  def rescue_handlers; end
  def rescue_handlers=(_arg0); end
  def rescue_handlers?; end
  def sendmail_settings; end
  def sendmail_settings=(_arg0); end
  def sendmail_settings?; end
  def show_previews; end
  def smtp_settings; end
  def smtp_settings=(_arg0); end
  def smtp_settings?; end
  def stylesheets_dir; end
  def stylesheets_dir=(value); end
  def test_settings; end
  def test_settings=(_arg0); end
  def test_settings?; end

  private

  def _layout(lookup_context, formats); end
  def _protected_ivars; end
  def apply_defaults(headers); end
  def assign_headers_to_message(message, headers); end
  def collect_responses(headers, &block); end
  def collect_responses_from_block(headers); end
  def collect_responses_from_templates(headers); end
  def collect_responses_from_text(headers); end
  def compute_default(value); end
  def create_parts_from_responses(m, responses); end
  def default_i18n_subject(interpolations = T.unsafe(nil)); end
  def each_template(paths, name, &block); end
  def insert_part(container, response, charset); end
  def instrument_name; end
  def instrument_payload(key); end
  def set_content_type(m, user_content_type, class_default); end
  def wrap_inline_attachments(message); end

  class << self
    def __callbacks; end
    def __callbacks=(value); end
    def __callbacks?; end
    def _helper_methods; end
    def _helper_methods=(value); end
    def _helper_methods?; end
    def _helpers; end
    def _layout; end
    def _layout=(value); end
    def _layout?; end
    def _layout_conditions; end
    def _layout_conditions=(value); end
    def _layout_conditions?; end
    def _process_action_callbacks; end
    def _process_action_callbacks=(value); end
    def _view_cache_dependencies; end
    def _view_cache_dependencies=(value); end
    def _view_cache_dependencies?; end
    def asset_host; end
    def asset_host=(value); end
    def assets_dir; end
    def assets_dir=(value); end
    def controller_path; end
    def default(value = T.unsafe(nil)); end
    def default_asset_host_protocol; end
    def default_asset_host_protocol=(value); end
    def default_options=(value = T.unsafe(nil)); end
    def default_params; end
    def default_params=(value); end
    def default_params?; end
    def default_static_extension; end
    def default_static_extension=(value); end
    def deliver_later_queue_name; end
    def deliver_later_queue_name=(val); end
    def deliver_mail(mail); end
    def delivery_job; end
    def delivery_job=(value); end
    def delivery_job?; end
    def delivery_method; end
    def delivery_method=(value); end
    def delivery_method?; end
    def delivery_methods; end
    def delivery_methods=(value); end
    def delivery_methods?; end
    def email_address_with_name(address, name); end
    def enable_fragment_cache_logging; end
    def enable_fragment_cache_logging=(value); end
    def file_settings; end
    def file_settings=(value); end
    def file_settings?; end
    def fragment_cache_keys; end
    def fragment_cache_keys=(value); end
    def fragment_cache_keys?; end
    def javascripts_dir; end
    def javascripts_dir=(value); end
    def logger; end
    def logger=(value); end
    def mailer_name; end
    def mailer_name=(_arg0); end
    def perform_caching; end
    def perform_caching=(value); end
    def perform_deliveries; end
    def perform_deliveries=(val); end
    def preview_interceptors; end
    def preview_interceptors=(val); end
    def preview_path; end
    def preview_path=(val); end
    def raise_delivery_errors; end
    def raise_delivery_errors=(val); end
    def register_interceptor(interceptor); end
    def register_interceptors(*interceptors); end
    def register_observer(observer); end
    def register_observers(*observers); end
    def relative_url_root; end
    def relative_url_root=(value); end
    def rescue_handlers; end
    def rescue_handlers=(value); end
    def rescue_handlers?; end
    def sendmail_settings; end
    def sendmail_settings=(value); end
    def sendmail_settings?; end
    def show_previews; end
    def show_previews=(val); end
    def smtp_settings; end
    def smtp_settings=(value); end
    def smtp_settings?; end
    def stylesheets_dir; end
    def stylesheets_dir=(value); end
    def supports_path?; end
    def test_settings; end
    def test_settings=(value); end
    def test_settings?; end
    def unregister_interceptor(interceptor); end
    def unregister_interceptors(*interceptors); end
    def unregister_observer(observer); end
    def unregister_observers(*observers); end

    private

    def method_missing(method_name, *args); end
    def observer_class_for(value); end
    def respond_to_missing?(method, include_all = T.unsafe(nil)); end
    def set_payload_for_mail(payload, mail); end
  end
end

module ActionMailer::Base::HelperMethods
  include(::ActionMailer::MailHelper)

  def combined_fragment_cache_key(*args, &block); end
  def view_cache_dependencies(*args, &block); end
end

class ActionMailer::Base::LateAttachmentsProxy < ::SimpleDelegator
  def []=(_name, _content); end
  def inline; end

  private

  def _raise_error; end
end

class ActionMailer::Base::NullMail
  def body; end
  def header; end
  def method_missing(*args); end
  def respond_to?(string, include_all = T.unsafe(nil)); end
end

ActionMailer::Base::PROTECTED_IVARS = T.let(T.unsafe(nil), Array)

class ActionMailer::Collector
  include(::AbstractController::Collector)

  def initialize(context, &block); end

  def all(*args, &block); end
  def any(*args, &block); end
  def custom(mime, options = T.unsafe(nil)); end
  def responses; end
end

class ActionMailer::DeliveryJob < ::ActiveJob::Base
  def perform(mailer, mail_method, delivery_method, *args); end

  private

  def handle_exception_with_mailer_class(exception); end
  def mailer_class; end

  class << self
    def __callbacks; end
    def queue_name; end
    def rescue_handlers; end
  end
end

module ActionMailer::DeliveryMethods
  extend(::ActiveSupport::Concern)

  mixes_in_class_methods(::ActionMailer::DeliveryMethods::ClassMethods)

  def wrap_delivery_behavior!(*args); end
end

module ActionMailer::DeliveryMethods::ClassMethods
  def add_delivery_method(symbol, klass, default_options = T.unsafe(nil)); end
  def deliveries(*_arg0, &_arg1); end
  def deliveries=(arg); end
  def wrap_delivery_behavior(mail, method = T.unsafe(nil), options = T.unsafe(nil)); end
end

class ActionMailer::InlinePreviewInterceptor
  include(::Base64)

  def initialize(message); end

  def transform!; end

  private

  def data_url(part); end
  def find_part(cid); end
  def html_part; end
  def message; end

  class << self
    def previewing_email(message); end
  end
end

ActionMailer::InlinePreviewInterceptor::PATTERN = T.let(T.unsafe(nil), Regexp)

class ActionMailer::MailDeliveryJob < ::ActiveJob::Base
  def perform(mailer, mail_method, delivery_method, args:, kwargs: T.unsafe(nil), params: T.unsafe(nil)); end

  private

  def handle_exception_with_mailer_class(exception); end
  def mailer_class; end

  class << self
    def queue_name; end
    def rescue_handlers; end
  end
end

module ActionMailer::MailHelper
  def attachments; end
  def block_format(text); end
  def format_paragraph(text, len = T.unsafe(nil), indent = T.unsafe(nil)); end
  def mailer; end
  def message; end
end

class ActionMailer::MessageDelivery
  def initialize(mailer_class, action, *args); end

  def __getobj__; end
  def __setobj__(mail_message); end
  def deliver_later(options = T.unsafe(nil)); end
  def deliver_later!(options = T.unsafe(nil)); end
  def deliver_now; end
  def deliver_now!; end
  def message; end
  def processed?; end

  private

  def enqueue_delivery(delivery_method, options = T.unsafe(nil)); end
  def processed_mailer; end
  def use_new_args?(job); end
end

module ActionMailer::Parameterized
  extend(::ActiveSupport::Concern)

  mixes_in_class_methods(::ActionMailer::Parameterized::ClassMethods)
end

module ActionMailer::Parameterized::ClassMethods
  def with(params); end
end

class ActionMailer::Parameterized::DeliveryJob < ::ActionMailer::DeliveryJob
  def perform(mailer, mail_method, delivery_method, params, *args); end
end

class ActionMailer::Parameterized::Mailer
  def initialize(mailer, params); end


  private

  def method_missing(method_name, *args); end
  def respond_to_missing?(method, include_all = T.unsafe(nil)); end
end

class ActionMailer::Parameterized::MessageDelivery < ::ActionMailer::MessageDelivery
  def initialize(mailer_class, action, params, *args); end


  private

  def delivery_job_class; end
  def enqueue_delivery(delivery_method, options = T.unsafe(nil)); end
  def processed_mailer; end
end

class ActionMailer::Preview
  extend(::ActiveSupport::DescendantsTracker)

  def initialize(params = T.unsafe(nil)); end

  def params; end

  class << self
    def all; end
    def call(email, params = T.unsafe(nil)); end
    def email_exists?(email); end
    def emails; end
    def exists?(preview); end
    def find(preview); end
    def preview_name; end

    private

    def inform_preview_interceptors(message); end
    def load_previews; end
    def preview_path; end
    def show_previews; end
  end
end

module ActionMailer::Previews
  extend(::ActiveSupport::Concern)

  mixes_in_class_methods(::ActionMailer::Previews::ClassMethods)
end

module ActionMailer::Previews::ClassMethods
  def register_preview_interceptor(interceptor); end
  def register_preview_interceptors(*interceptors); end
  def unregister_preview_interceptor(interceptor); end
  def unregister_preview_interceptors(*interceptors); end

  private

  def interceptor_class_for(interceptor); end
end

class ActionMailer::Railtie < ::Rails::Railtie
end

class ActionMailer::TestCase < ::ActiveSupport::TestCase
  include(::ActiveSupport::Testing::ConstantLookup)
  include(::ActiveJob::TestHelper)
  include(::ActionMailer::TestHelper)
  include(::Rails::Dom::Testing::Assertions::SelectorAssertions::CountDescribable)
  include(::Rails::Dom::Testing::Assertions::SelectorAssertions)
  include(::Rails::Dom::Testing::Assertions::DomAssertions)
  include(::ActionMailer::TestCase::Behavior)
  extend(::ActiveSupport::Testing::ConstantLookup::ClassMethods)
  extend(::ActionMailer::TestCase::Behavior::ClassMethods)

  def _mailer_class; end
  def _mailer_class=(_arg0); end
  def _mailer_class?; end

  class << self
    def __callbacks; end
    def _mailer_class; end
    def _mailer_class=(value); end
    def _mailer_class?; end
  end
end

module ActionMailer::TestCase::Behavior
  include(::ActiveJob::TestHelper)
  include(::ActionMailer::TestHelper)
  include(::Rails::Dom::Testing::Assertions::SelectorAssertions::CountDescribable)
  include(::Rails::Dom::Testing::Assertions::SelectorAssertions)
  include(::Rails::Dom::Testing::Assertions::DomAssertions)
  extend(::ActiveSupport::Concern)

  include(::ActiveSupport::Testing::ConstantLookup)

  mixes_in_class_methods(::ActionMailer::TestCase::Behavior::ClassMethods)


  private

  def charset; end
  def encode(subject); end
  def initialize_test_deliveries; end
  def read_fixture(action); end
  def restore_delivery_method; end
  def restore_test_deliveries; end
  def set_delivery_method(method); end
  def set_expected_mail; end
end

module ActionMailer::TestCase::Behavior::ClassMethods
  def determine_default_mailer(name); end
  def mailer_class; end
  def tests(mailer); end
end

module ActionMailer::TestCase::ClearTestDeliveries
  extend(::ActiveSupport::Concern)


  private

  def clear_test_deliveries; end
end

module ActionMailer::TestHelper
  include(::ActiveJob::TestHelper)

  def assert_emails(number, &block); end
  def assert_enqueued_email_with(mailer, method, args: T.unsafe(nil), queue: T.unsafe(nil), &block); end
  def assert_enqueued_emails(number, &block); end
  def assert_no_emails(&block); end
  def assert_no_enqueued_emails(&block); end

  private

  def delivery_job_filter(job); end
end

module ActionMailer::VERSION
end

ActionMailer::VERSION::MAJOR = T.let(T.unsafe(nil), Integer)

ActionMailer::VERSION::MINOR = T.let(T.unsafe(nil), Integer)

ActionMailer::VERSION::PRE = T.let(T.unsafe(nil), String)

ActionMailer::VERSION::STRING = T.let(T.unsafe(nil), String)

ActionMailer::VERSION::TINY = T.let(T.unsafe(nil), Integer)

class ActionMailer::LogSubscriber < ::ActiveSupport::LogSubscriber
  def deliver(event); end
  def logger; end
  def process(event); end
end

class ActionMailer::NonInferrableMailerError < ::StandardError
  def initialize(name); end
end

module ActionMailer::Rescuable
  extend(::ActiveSupport::Concern)

  include(::ActiveSupport::Rescuable)

  mixes_in_class_methods(::ActionMailer::Rescuable::ClassMethods)

  def handle_exceptions; end

  private

  def process(*_arg0); end
end

module ActionMailer::Rescuable::ClassMethods
  def handle_exception(exception); end
end
