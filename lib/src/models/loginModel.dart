
class LoginModel {
  List<String>? roles;
  String? token;
  Debug? debug;

  LoginModel({this.roles, this.token, this.debug});

  LoginModel.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
    token = json['token'];
    debug = json['debug'] != null ? Debug.fromJson(json['debug']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roles'] = roles;
    data['token'] = token;
    if (debug != null) {
      data['debug'] = debug!.toJson();
    }
    return data;
  }
}

class Debug {
  Database? database;
  Cache? cache;
  List<Profiling>? profiling;
  Memory? memory;

  Debug({this.database, this.cache, this.profiling, this.memory});

  Debug.fromJson(Map<String, dynamic> json) {
    database = json['database'] != null
        ?  Database.fromJson(json['database'])
        : null;
    cache = json['cache'] != null ?  Cache.fromJson(json['cache']) : null;
    if (json['profiling'] != null) {
      profiling =  [];
      json['profiling'].forEach((v) {
        profiling!.add( Profiling.fromJson(v));
      });
    }
    memory =
        json['memory'] != null ?  Memory.fromJson(json['memory']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (database != null) {
      data['database'] = database!.toJson();
    }
    if (cache != null) {
      data['cache'] = cache!.toJson();
    }
    if (profiling != null) {
      data['profiling'] = profiling!.map((v) => v.toJson()).toList();
    }
    if (memory != null) {
      data['memory'] = memory!.toJson();
    }
    return data;
  }
}

class Database {
  int? total;
  List<Items>? items;

  Database({this.total, this.items});

  Database.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      items =  [];
      json['items'].forEach((v) {
        items!.add( Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['total'] = total;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? connection;
  String? query;
  double? time;

  Items({this.connection, this.query, this.time});

  Items.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    query = json['query'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['connection'] = connection;
    data['query'] = query;
    data['time'] = time;
    return data;
  }
}

class Cache {
  Hit? hit;
  Hit? miss;
  Write? write;
  Write? forget;

  Cache({this.hit, this.miss, this.write, this.forget});

  Cache.fromJson(Map<String, dynamic> json) {
    hit = json['hit'] != null ?  Hit.fromJson(json['hit']) : null;
    miss = json['miss'] != null ?  Hit.fromJson(json['miss']) : null;
    write = json['write'] != null ?  Write.fromJson(json['write']) : null;
    forget = json['forget'] != null ?  Write.fromJson(json['forget']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (hit != null) {
      data['hit'] = hit!.toJson();
    }
    if (miss != null) {
      data['miss'] = miss!.toJson();
    }
    if (write != null) {
      data['write'] = write!.toJson();
    }
    if (forget != null) {
      data['forget'] = forget!.toJson();
    }
    return data;
  }
}

class Hit {
  List<String>? keys;
  int? total;

  Hit({this.keys, this.total});

  Hit.fromJson(Map<String, dynamic> json) {
    keys = json['keys'].cast<String>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['keys'] = keys;
    data['total'] = total;
    return data;
  }
}

class Write {
 List<String>? keys;
  int? total;

  Write({this.keys, this.total});

  Write.fromJson(Map<String, dynamic> json) {
    keys = json['keys'].cast<String>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['keys'] = keys;
    data['total'] = total;
    return data;
  }
}

class Profiling {
  String? event;
  double? time;

  Profiling({this.event, this.time});

  Profiling.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['event'] = event;
    data['time'] = time;
    return data;
  }
}

class Memory {
  int? usage;
  int? peak;

  Memory({this.usage, this.peak});

  Memory.fromJson(Map<String, dynamic> json) {
    usage = json['usage'];
    peak = json['peak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['usage'] = usage;
    data['peak'] = peak;
    return data;
  }
}
