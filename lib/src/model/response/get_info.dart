class GetInfoResponse {
  GetInfoResponse({
    required this.name,
    required this.pubkey,
    required this.version,
    required this.description,
    required this.descriptionLong,
    required this.contact,
    required this.motd,
    required this.nuts,
  });

  final String name;
  final String? pubkey;
  final String? version;
  final String? description;
  final String? descriptionLong;
  final List<InfoContact>? contact;
  final String? motd;
  final Map<int, InfoNut>? nuts;

  factory GetInfoResponse.fromJson(Map<String, dynamic> json) {
    return GetInfoResponse(
      name: json['name'] as String,
      pubkey: json['pubkey'] as String?,
      version: json['version'] as String?,
      description: json['description'] as String?,
      descriptionLong: json['description_long'] as String?,
      contact: (json['contact'] as List<dynamic>?)
          ?.map((e) => InfoContact.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      motd: json['motd'] as String?,
      nuts: (json['nuts'] as Map<String, dynamic>?)?.map((key, value) {
        return MapEntry(int.parse(key), InfoNut.fromJson(value));
      }),
    );
  }
}

class InfoContact {
  InfoContact({
    required this.type,
    required this.address,
  });

  final String type;
  final String address;

  factory InfoContact.fromJson(Map<String, dynamic> json) {
    return InfoContact(
      type: json['type'] as String,
      address: json['address'] as String,
    );
  }
}

class InfoNut {
  InfoNut({
    this.methods,
    this.disabled,
    this.supported,
  });

  final List<dynamic>? methods;
  final bool? disabled;
  final bool? supported;

  factory InfoNut.fromJson(Map<String, dynamic> json) {
    return InfoNut(
      methods: json['methods'] as List<dynamic>?,
      disabled: json['disabled'] as bool?,
      supported: json['supported'] as bool?,
    );
  }
}
