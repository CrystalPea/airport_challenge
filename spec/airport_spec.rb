require 'airport'
describe Airport do

  it { is_expected.to be_instance_of(Airport) }

  describe "#land" do
    it { is_expected.to respond_to(:land).with(1).argument }

    it "tells a plane to land" do
      plane = Plane.new
      weather = "good"
      subject.land(plane)
      expect(plane).to eq subject.planes.last
    end

    it "doesn't allow plane to land if weather stormy" do
      plane = Plane.new
      subject.weather = "stormy"
      expect { subject.land(plane) }.to raise_error("Landing impossible due to stormy weather")
    end

    it "Doesn't allow planes to land if full" do
      subject.weather = "good"
      (subject.capacity).times { subject.land(Plane.new)}
      expect { subject.land(Plane.new) }.to raise_error("This airport is full")
    end

  end

  describe "#on_airport?" do
    it "confirms that a plane is landed there/has not taken off" do
      plane = Plane.new
      weather = "good"
      subject.land(plane)
      expect(subject.on_airport?(plane)).to eq true
    end

    it "informs if the plane is not landed at this airport/has taken off" do
      expect(subject.on_airport?(Plane.new)).to eq false
    end
  end

  describe "#take_off" do
    it { is_expected.to respond_to(:take_off).with(1).argument }

    it "instructs a plane to take_off" do
      plane = Plane.new
      subject.weather = "good"
      subject.land(plane)
      subject.take_off(plane)
      expect(subject.planes).not_to include plane
    end

    it "doesn't allow plane to take off if weather stormy" do
      plane = Plane.new
      subject.land(plane)
      subject.weather = "stormy"
      expect { subject.take_off(plane) }.to raise_error("Take-off impossible due to stormy weather")
    end
  end

end
