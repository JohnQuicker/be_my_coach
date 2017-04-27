class WelcomeController < ApplicationController
  
# 测试flash效果
  def index
    flash[:notice] = "欢迎，你好！"
  end

end
