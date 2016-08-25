class Rails::AngularJsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :attributes, :type => :array, :default => [], :banner => 'field:type field:type'

  # def create_angular_js_folder
  #   empty_directory "app/assets/javascripts/controllers"
  # end

  def create_angular_js_file
    # angular js 文件
    template 'angular.coffee.erb', File.join('app/assets/javascripts/controllers', "#{file_name}_controller.coffee")

    content = <<~REQ
      // require angular controllers
      //= require controllers/#{file_name}_controller.coffee
    REQ

    # 引入js文件
    create_file "app/assets/javascripts/#{file_name}.js", content
  end
end
