#Nanda Yadav(nandayadav@gmail.co)
#Solar system animation in ruby/opengl
require 'rubygems'
require 'opengl'
require 'glut'

class Solarsystem
  
  #Constants
  MATSPECULAR = [1.0, 1.0, 1.0, 0.15]
  MATSHININESS = [100.0]
  LIGHT0DIFFUSE = [1.0, 1.0, 1.0, 1.0]
  LIGHT0POSITION = [1.0, 1.0, 1.0, 0.0]
  
  MATSOLID = [0.9, 0.75, 0.0, 1.0]
  MATZERO = [0.0, 0.0, 0.0, 1.0]
  MATTRANSPARENT = [0.0, 0.8, 0.3, 0.6]
  #for Sun
  MATEMISSION = [0.9, 0.3, 0.0, 0.8]
  #for earth
  MATEMISSION1 = [0.3, 0.7, 0.5, 0.4]
  
 

  def init
    
    @year = 0.0
    @day = 0.0
    
    GL.ClearColor(0.1, 0.1, 0.2, 0.0)
    GL.ShadeModel(GL::SMOOTH)
    
    GL.Material(GL::FRONT, GL::SPECULAR, MATSPECULAR)
    GL.Material(GL::FRONT, GL::SHININESS, MATSHININESS)
    GL.Lightfv(GL::LIGHT0, GL::DIFFUSE, LIGHT0DIFFUSE)
    GL.Lightfv(GL::LIGHT0, GL::POSITION, LIGHT0POSITION)
    
    GL.Enable(GL::LIGHTING)
    GL.Enable(GL::LIGHT0)
    GL.Enable(GL::DEPTH_TEST)
  end
  
  def display
    
    GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
    GL.Color3f(1.0, 1.0, 1.0)
    GL.Material(GL::FRONT, GL::AMBIENT_AND_DIFFUSE, MATEMISSION)
    GL.PushMatrix()
    GL.Rotate(@year, 0, 1, 0)
    GLUT.SolidSphere(0.8, 50, 50)
    GL.Material(GL::FRONT, GL::AMBIENT_AND_DIFFUSE, MATEMISSION1)
    GL.Translate(2, 0, 0)
    GL.Rotate(@day, 0, 1, 0)
    GLUT.SolidSphere(0.2, 45, 45)
    GL.PopMatrix()
    
    GLUT.SwapBuffers()
  end
  
  def yeardisplay
    @year = @year + 0.1
    @day = @day + 0.1
    GLUT.PostRedisplay()
  end
  
  def reshape(width, height)
    GL.Viewport(0, 0, width, height)
    GL.MatrixMode(GL::PROJECTION)
    GL.LoadIdentity()
    GLU.Perspective(60.0, width/height, 1.0, 20.0)
    GL.MatrixMode(GL::MODELVIEW)
    GL.LoadIdentity()
    GLU.LookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, -0.2, 1.0, 0.0)
  end
  
  def keyboard(key, x, y)
    case key
    when ?y
      GLUT.IdleFunc(method(:yeardisplay).to_proc)
    when ?n
      GLUT.IdleFunc(method(:display).to_proc)
    when 27 # Escape
        exit
    end
  end
  
  def initialize
    GLUT.Init()
    GLUT.InitDisplayMode( GLUT::DOUBLE | GLUT::RGB | GLUT::DEPTH)
    GLUT.InitWindowSize( 500, 500)
    GLUT.InitWindowPosition( 100, 100)
    GLUT.CreateWindow("Animation: Solar System")
    init()
    
    GLUT.DisplayFunc(method(:display).to_proc)
    GLUT.ReshapeFunc(method(:reshape).to_proc)
    GLUT.KeyboardFunc(method(:keyboard).to_proc)
    
    GLUT.MainLoop()
  end
  
  def start
    GLUT.MainLoop()
  end
end

Solarsystem.new.start
  
  
  
    
  

