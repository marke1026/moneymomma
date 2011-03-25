module OpenFlashChart
  class Graph
    attr_accessor :ofc_url, :width, :height, :div_name, :swf_name, :base_path
    
    def initialize(url, width = 600, height = 400, options = {})
      @width, @height = width, height
      @use_swfobject = options[:swfobject] || false
      @base_path = options[:base_path] || "/"
      @swf_name = options[:swf_name] || "open-flash-chart.swf"
      
      random_hash = ActiveSupport::SecureRandom.hex(7)
      @div_name = options[:div_name] || "flash_chart_#{random_hash}"
      
      @ofc_url = CGI::escape(url)
    end
    
    def swf_path(swf_file_name)
      File.join(@base_path, swf_file_name)
    end
    
    def to_html(create_div = true)
      html = []
      html << '<script type="text/javascript" src="/javascripts/swfobject.js"></script>' if @use_swfobject
      html << "<div id='#{@div_name}'></div>" if create_div
      html << "<script type='text/javascript'>
        swfobject.embedSWF('#{swf_path(@swf_name)}', '#{@div_name}', '#{@width}', '#{@height}', '9.0.0', '#{swf_path('expressInstall.swf')}', {'data-file':'#{@ofc_url}'});
      </script>"
      
      html.join
    end
    
    def save_image_popup_script(options = {})
      id = options[:id] || @div_name
      
      <<-OUTPUT
        <script type="text/javascript"> 
          OFC = {};
   
          OFC.jquery = {
              name: "jQuery",
              version: function(src) { return $('#'+ src)[0].get_version() },
              rasterize: function (src, dst) { $('#'+ dst).replaceWith(OFC.jquery.image(src)) },
              image: function(src) { return "<img src='data:image/png;base64," + $('#'+src)[0].get_img_binary() + "' />"},
              popup: function(src) {
                  var img_win = window.open('', "Charts: Export as Image")
                  with(img_win.document) {
                      write("<html><head><title>Charts: Export as Image<\/title><\/head><body>" + OFC.jquery.image(src) + "<\/body><\/html>")      
                  }
		              // stop the 'loading...' message
		              img_win.document.close();
               }
          }
   
          // Using an object as namespaces is JS Best Practice. I like the Control.XXX style.
          if (typeof(Control == "undefined")) {var Control = {OFC: OFC.jquery}}
     
          // By default, right-clicking on OFC and choosing "save image locally" calls this function.
          // You are free to change the code in OFC and call my wrapper (Control.OFC.your_favorite_save_method)
          // function save_image() { alert(1); Control.OFC.popup('my_chart') }
          function save_image() { OFC.jquery.popup('#{id}') }
        </script>
      OUTPUT
    end
    
    def save_image_button(title, options = {})
      debug = options[:debug] ? 'true' : 'false'
      post_url = options[:url] || '/'
      
      html = []
      html << "<input type='button' value='#{title}' onclick='post_image(#{debug});return false;' />"
      html << save_image_script(post_url, options)
      html.join
    end
    
    def save_image_script(post_url, options = {})
      id = options[:id] || @div_name

      <<-OUTPUT
        <script type="text/javascript">
          #{findswf_script}

          function post_image(debug)
          {
            var url = '#{post_url}';
            var ofc = findSWF('#{id}');
            var x = ofc.post_image(url, '#{options[:post_image_callback_method]}', debug );
          }
          
          function ofc_ready() {
            #{options[:ofc_ready_callback_method]};
          }
        </script>
      OUTPUT
    end
    
    def findswf_script
      <<-OUTPUT
        function findSWF(movieName) {
          if (navigator.appName.indexOf("Microsoft")!= -1) {
            return window[movieName];
          } else {
            return document[movieName];
          }
        }
      OUTPUT
    end
  end
end
