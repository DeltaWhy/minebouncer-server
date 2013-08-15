class Game < ActiveRecord::Base
  belongs_to :user
  validates :host, presence: true
  validates :port, presence: true, inclusion: 1024..65535

  before_validation :choose_port, on: :create

  private
  def choose_port
    host = ENV["TUNNEL_HOST"] if host.blank?
    while self.port.blank?
      try_port = (1024..65535).to_a.sample
      #puts("trying #{host} #{try_port}")
      unless is_open?(host, try_port)
        self.port = try_port
      end
    end
  end

  def is_open?(host, port)
    system("netcat -w 1 -z #{host} #{port}")
  end
end