class Doctor {
  final int id;
  final String name;
  final String specialization;
  final String imageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
  });
  static final List<Doctor> doctors = [
    Doctor(
      id: 101,
      name: 'Dr. John Doe',
      specialization: 'Cardiologist',
      imageUrl: 'https://example.com/image1.jpg',
    ),
    Doctor(
      id: 102,
      name: 'Dr. Jane Smith',
      specialization: 'Neurologist',
      imageUrl: 'https://example.com/image2.jpg',
    ),
    Doctor(
      id: 103,
      name: 'Dr. Emily Clark',
      specialization: 'Dermatologist',
      imageUrl: 'https://example.com/image3.jpg',
    ),
  ];
}
