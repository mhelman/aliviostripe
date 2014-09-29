class PatientsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def create
    @patient = current_user.patients.build(params[:patient])
    if @patient.save
      redirect_to root_path, :flash => { :success => "patient created!" }
    else
      render 'pages/home'
    end
  end

  def destroy
    @patient.destroy
    redirect_to root_path, :flash => { :success => "patient deleted!" }
  end
  
  def index
    @patients = current_user.patients.paginate(:page => params[:page])
    @title = "All patients"
  end    
  def new
    @patient = current_user.patients.build(params[:patient])
    @title = "New patient" 
  end
  
  def show
    @patient = current_user.patients.find(params[:id])
    @title = @patient.firstName
  end

  def authorized_user
      @patient = current_user.patients.find_by_id(params[:id])
      redirect_to root_path if @patient.nil?
  end
  
  def reports
      @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Patient exercise scores in week ending on 9/27"})
      f.options[:xAxis][:categories] = ['Exercise 1', 'Exercise 2', 'Exercise 3', 'Exercise 4', 'Exercise 5']
      f.labels(:items=>[:html=>"Total scores", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
      f.series(:type=> 'column',:name=> 'Jane Smith',:data=> [3, 2, 1, 3, 4])
      f.series(:type=> 'column',:name=> 'John Edwards',:data=> [2, 3, 5, 7, 6])
      f.series(:type=> 'column', :name=> 'Joe Doe',:data=> [4, 3, 3, 9, 0])
      f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
      f.series(:type=> 'pie',:name=> 'Total scores', 
        :data=> [
          {:name=> 'Jane Smith', :y=> 13, :color=> 'red'}, 
          {:name=> 'John Edwards', :y=> 23,:color=> 'green'},
          {:name=> 'Joe Doe', :y=> 19,:color=> 'blue'}
        ],
        :center=> [100, 80], :size=> 100, :showInLegend=> false)
        @h = LazyHighCharts::HighChart.new('graph') do |f|
                        f.series(:name=>'John Edwards', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
                        f.series(:name=>'Jane Smith', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
                end
 end
  end
  
  
    
end
