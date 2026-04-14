class Track {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final String audioUrl;
  final Duration duration;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
  });
}

final List<Track> elitePlaylist = [
  const Track(
    id: 't1',
    title: 'Neon Nights',
    artist: 'Cyber Synth',
    album: 'Retrowave 2026',
    coverUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=400&h=400&fit=crop',
    audioUrl: 'https://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/theme_01.mp3',
    duration: Duration(minutes: 6, seconds: 12),
  ),
  const Track(
    id: 't2',
    title: 'Code Compiling',
    artist: 'Lofi Dev',
    album: 'Deep Focus',
    coverUrl: 'https://picsum.photos/seed/code1/400/400',
    audioUrl: 'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
    duration: Duration(minutes: 7, seconds: 5),
  ),
  const Track(
    id: 't3',
    title: 'Midnight Commit',
    artist: 'The Architects',
    album: 'Enterprise Flows',
    coverUrl: 'https://picsum.photos/seed/code2/400/400',
    audioUrl: 'https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3',
    duration: Duration(minutes: 5, seconds: 44),
  ),
  const Track(
    id: 't4',
    title: 'Deployment Success',
    artist: 'Orchestral Code',
    album: 'Symphony of CI/CD',
    coverUrl: 'https://picsum.photos/seed/code/400/400',
    audioUrl: 'https://codeskulptor-demos.commondatastorage.googleapis.com/descent/Cymbal%20Crash.mp3',
    duration: Duration(minutes: 5, seconds: 2),
  )
];
