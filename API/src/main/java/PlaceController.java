import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/places")
public class PlaceController {

    @GetMapping("/getAllPlace")
    public List<Place> getAllPlaces() {
        List<Place> places = new ArrayList<>();
        places.add(new Place("Hoi An", 4.0, "https://link-to-image/hoian.jpg"));
        places.add(new Place("Sai Gon", 4.5, "https://link-to-image/saigon.jpg"));
        return places;
    }
}

class Place {
    private String name;
    private double rating;
    private String image;

    public Place(String name, double rating, String image) {
        this.name = name;
        this.rating = rating;
        this.image = image;
    }

    // Getters and setters
}
