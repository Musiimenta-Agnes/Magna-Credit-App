

// import 'package:flutter/material.dart';
// import 'package:magna_credit_app/api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // ─── Theme Colors ────────────────────────────────────────────────
// const Color kBlue  = Color(0xFF0076D6);
// const Color kGreen = Color(0xFF00CB5E);
// const Color kBg    = Color(0xFFF4F8FF);

// // ════════════════════════════════════════════════════════════════
// //  NotificationsPage
// // ════════════════════════════════════════════════════════════════
// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   bool isLoading     = true;
//   List notifications = [];
//   int  unreadCount   = 0;

//   // Which notification is currently open in detail view (null = list view)
//   Map? _openNotification;

//   @override
//   void initState() {
//     super.initState();
//     _load();
//   }

//   Future<void> _load() async {
//     try {
//       final data = await ApiService.getNotifications();
//       setState(() {
//         notifications = List.from(data['notifications'] ?? []);
//         unreadCount   = data['unread_count'] ?? 0;
//         isLoading     = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//     }
//   }

//   // ── Open detail view and mark as read ──
//   Future<void> _openDetail(Map n) async {
//     setState(() => _openNotification = n);

//     // Mark as read if unread — only affects bell count, keeps in list
//     if (n['is_read'] == false) {
//       try {
//         await ApiService.markNotificationRead(n['id']);
//         setState(() {
//           final idx = notifications.indexWhere((x) => x['id'] == n['id']);
//           if (idx != -1) {
//             notifications[idx] = Map.from(notifications[idx])..['is_read'] = true;
//           }
//           if (unreadCount > 0) unreadCount--;
//           _openNotification = Map.from(n)..['is_read'] = true;
//         });
//       } catch (_) {}
//     }
//   }

//   // ── Close detail view, go back to list ──
//   void _closeDetail() {
//     setState(() => _openNotification = null);
//   }

//   // ── Clear (delete) a notification permanently ──
//   Future<void> _clearNotification(Map n) async {
//     try {
//       await ApiService.clearNotification(n['id']);
//       setState(() {
//         notifications.removeWhere((x) => x['id'] == n['id']);
//         // If it was still unread when cleared, remove from bell count too
//         if (n['is_read'] == false && unreadCount > 0) unreadCount--;
//         _openNotification = null;
//       });
//     } catch (_) {}
//   }

//   IconData _icon(String type) => switch (type) {
//     'repayment'   => Icons.payments_rounded,
//     'loan_status' => Icons.account_balance_rounded,
//     _             => Icons.notifications_rounded,
//   };

//   Color _color(String type) => switch (type) {
//     'repayment'   => kGreen,
//     'loan_status' => kBlue,
//     _             => Colors.orange,
//   };

//   String _timeAgo(String? createdAt) {
//     if (createdAt == null) return '';
//     final dt = DateTime.tryParse(createdAt);
//     if (dt == null) return '';
//     final diff = DateTime.now().difference(dt);
//     if (diff.inSeconds < 60) return 'Just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24)   return '${diff.inHours}h ago';
//     if (diff.inDays < 7)     return '${diff.inDays}d ago';
//     return '${dt.day}/${dt.month}/${dt.year}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     // ── Detail view ──
//     if (_openNotification != null) {
//       return _DetailView(
//         notification: _openNotification!,
//         isDark:       isDark,
//         icon:         _icon(_openNotification!['type'] ?? ''),
//         color:        _color(_openNotification!['type'] ?? ''),
//         timeAgo:      _timeAgo(_openNotification!['created_at']),
//         onClose:      _closeDetail,
//         onClear:      () => _clearNotification(_openNotification!),
//       );
//     }

//     // ── List view ──
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
//       appBar: AppBar(
//         backgroundColor: kBlue,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text('Notifications',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18)),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(3),
//           child: Container(
//             height: 3,
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(colors: [kBlue, kGreen])),
//           ),
//         ),
//         actions: const [],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator(color: kBlue))
//           : notifications.isEmpty
//               ? _emptyState(isDark)
//               : RefreshIndicator(
//                   onRefresh: _load,
//                   color: kBlue,
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     itemCount: notifications.length,
//                     itemBuilder: (_, i) => _NotificationCard(
//                       notification: notifications[i],
//                       isDark:  isDark,
//                       icon:    _icon(notifications[i]['type'] ?? ''),
//                       color:   _color(notifications[i]['type'] ?? ''),
//                       timeAgo: _timeAgo(notifications[i]['created_at']),
//                       onRead:  () => _openDetail(notifications[i]),
//                     ),
//                   ),
//                 ),
//     );
//   }

//   Widget _emptyState(bool isDark) {
//     return Center(
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//               color: kBlue.withOpacity(0.07), shape: BoxShape.circle),
//           child: const Icon(Icons.notifications_none_rounded,
//               size: 56, color: kBlue),
//         ),
//         const SizedBox(height: 16),
//         const Text('No notifications yet',
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w700, color: kBlue)),
//         const SizedBox(height: 8),
//         Text(
//           'You will be notified when there are\nupdates on your loans or repayments.',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 13, color: Colors.grey[600], height: 1.5),
//         ),
//       ]),
//     );
//   }
// }

// // ════════════════════════════════════════════════════════════════
// //  Detail View — shown when a notification is opened
// // ════════════════════════════════════════════════════════════════
// class _DetailView extends StatelessWidget {
//   final Map        notification;
//   final bool       isDark;
//   final IconData   icon;
//   final Color      color;
//   final String     timeAgo;
//   final VoidCallback onClose;
//   final VoidCallback onClear;

//   const _DetailView({
//     required this.notification,
//     required this.isDark,
//     required this.icon,
//     required this.color,
//     required this.timeAgo,
//     required this.onClose,
//     required this.onClear,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
//       appBar: AppBar(
//         backgroundColor: kBlue,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Notification',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18)),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(3),
//           child: Container(
//             height: 3,
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(colors: [kBlue, kGreen])),
//           ),
//         ),
//         // ── X button to go back to the list ──
//         leading: IconButton(
//           icon: const Icon(Icons.close_rounded, color: Colors.white),
//           onPressed: onClose,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Icon + type badge ──
//             Row(children: [
//               Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                     color: color.withOpacity(0.12),
//                     borderRadius: BorderRadius.circular(16)),
//                 child: Icon(icon, color: color, size: 28),
//               ),
//               const SizedBox(width: 14),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: color.withOpacity(0.25)),
//                   ),
//                   child: Text(
//                     notification['type'] == 'repayment'
//                         ? 'Repayment'
//                         : 'Loan update',
//                     style: TextStyle(
//                         fontSize: 11,
//                         color: color,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(children: [
//                   Icon(Icons.access_time_rounded,
//                       size: 11,
//                       color: isDark ? Colors.white38 : Colors.black38),
//                   const SizedBox(width: 4),
//                   Text(timeAgo,
//                       style: TextStyle(
//                           fontSize: 11,
//                           color: isDark ? Colors.white38 : Colors.black38)),
//                 ]),
//               ]),
//             ]),

//             const SizedBox(height: 24),

//             // ── Message card ──
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: isDark ? const Color(0xFF111827) : Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: color.withOpacity(0.2)),
//                 boxShadow: [
//                   BoxShadow(
//                       color: color.withOpacity(0.08),
//                       blurRadius: 16,
//                       offset: const Offset(0, 4)),
//                 ],
//               ),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 // Title
//                 Text(
//                   notification['title'] ?? '',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 // Divider
//                 Container(
//                     height: 1,
//                     color: isDark
//                         ? Colors.white.withOpacity(0.07)
//                         : Colors.black.withOpacity(0.07)),
//                 const SizedBox(height: 12),
//                 // Body
//                 Text(
//                   notification['body'] ?? '',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: isDark ? Colors.white70 : Colors.black54,
//                     height: 1.6,
//                   ),
//                 ),
//               ]),
//             ),

//             const Spacer(),

//             // ── Clear message button ──
//             GestureDetector(
//               onTap: onClear,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                   color: Colors.redAccent.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(16),
//                   border:
//                       Border.all(color: Colors.redAccent.withOpacity(0.3)),
//                 ),
//                 child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                   Icon(Icons.delete_outline_rounded,
//                       color: Colors.redAccent, size: 20),
//                   SizedBox(width: 10),
//                   Text('Clear message',
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.redAccent,
//                           letterSpacing: 0.3)),
//                 ]),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ════════════════════════════════════════════════════════════════
// //  Notification Card — shown in list view
// // ════════════════════════════════════════════════════════════════
// class _NotificationCard extends StatelessWidget {
//   final Map        notification;
//   final bool       isDark;
//   final IconData   icon;
//   final Color      color;
//   final String     timeAgo;
//   final VoidCallback onRead;

//   const _NotificationCard({
//     required this.notification,
//     required this.isDark,
//     required this.icon,
//     required this.color,
//     required this.timeAgo,
//     required this.onRead,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isUnread = notification['is_read'] == false;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: isUnread
//             ? (isDark ? color.withOpacity(0.12) : color.withOpacity(0.06))
//             : (isDark ? const Color(0xFF111827) : Colors.white),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isUnread
//               ? color.withOpacity(0.3)
//               : (isDark
//                   ? Colors.white.withOpacity(0.06)
//                   : Colors.black.withOpacity(0.06)),
//           width: isUnread ? 1.5 : 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // ── Icon ──
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               color: color.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(12)),
//           child: Icon(icon, color: color, size: 22),
//         ),
//         const SizedBox(width: 12),

//         // ── Content ──
//         Expanded(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//             // Title row with unread dot
//             Row(children: [
//               Expanded(
//                 child: Text(
//                   notification['title'] ?? '',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight:
//                         isUnread ? FontWeight.w700 : FontWeight.w600,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),
//               ),
//               if (isUnread)
//                 Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                       color: color, shape: BoxShape.circle),
//                 ),
//             ]),
//             const SizedBox(height: 4),

//             // Body preview (2 lines max)
//             Text(
//               notification['body'] ?? '',
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: isDark ? Colors.white60 : Colors.black54,
//                   height: 1.4),
//             ),
//             const SizedBox(height: 8),

//             // Bottom row: time + type badge + READ button
//             Row(children: [
//               Icon(Icons.access_time_rounded,
//                   size: 11,
//                   color: isDark ? Colors.white38 : Colors.black38),
//               const SizedBox(width: 4),
//               Text(timeAgo,
//                   style: TextStyle(
//                       fontSize: 11,
//                       color: isDark ? Colors.white38 : Colors.black38)),
//               const Spacer(),
//               // ── READ button ──
//               GestureDetector(
//                 onTap: onRead,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 14, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     isUnread ? 'Read' : 'View',
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//             ]),
//           ]),
//         ),
//       ]),
//     );
//   }
// }

// // ════════════════════════════════════════════════════════════════
// //  NotificationBell — add to any AppBar actions
// // ════════════════════════════════════════════════════════════════
// class NotificationBell extends StatefulWidget {
//   const NotificationBell({super.key});

//   @override
//   State<NotificationBell> createState() => _NotificationBellState();
// }

// class _NotificationBellState extends State<NotificationBell>
//     with WidgetsBindingObserver {
//   int _unread = 0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadCount();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   // Re-fetch when app comes back to foreground
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) _loadCount();
//   }

//   Future<void> _loadCount() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       if (token.isEmpty) {
//         if (mounted) setState(() => _unread = 0);
//         return;
//       }
//       final data = await ApiService.getNotifications();
//       if (mounted) setState(() => _unread = data['unread_count'] ?? 0);
//     } catch (_) {
//       if (mounted) setState(() => _unread = 0);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const NotificationsPage()),
//         );
//         // Always re-fetch from backend when returning — ensures bell is accurate
//         await _loadCount();
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(right: 16),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             const Icon(Icons.notifications_rounded,
//                 color: Colors.white, size: 26),
//             if (_unread > 0)
//               Positioned(
//                 top: -4,
//                 right: -4,
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                       color: Colors.redAccent, shape: BoxShape.circle),
//                   constraints:
//                       const BoxConstraints(minWidth: 16, minHeight: 16),
//                   child: Text(
//                     _unread > 99 ? '99+' : '$_unread',
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 9,
//                         fontWeight: FontWeight.w700),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magna_credit_app/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Theme Colors ────────────────────────────────────────────────
const Color kBlue  = Color(0xFF0076D6);
const Color kGreen = Color(0xFF00CB5E);
const Color kBg    = Color(0xFFF4F8FF);

// ════════════════════════════════════════════════════════════════
//  NotificationsPage
// ════════════════════════════════════════════════════════════════
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isLoading     = true;
  List notifications = [];
  int  unreadCount   = 0;

  // Which notification is currently open in detail view (null = list view)
  Map? _openNotification;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getNotifications();
      setState(() {
        notifications = List.from(data['notifications'] ?? []);
        unreadCount   = data['unread_count'] ?? 0;
        isLoading     = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  // ── Open detail view and mark as read ──
  Future<void> _openDetail(Map n) async {
    setState(() => _openNotification = n);

    // Mark as read if unread — only affects bell count, keeps in list
    if (n['is_read'] == false) {
      try {
        await ApiService.markNotificationRead(n['id']);
        setState(() {
          final idx = notifications.indexWhere((x) => x['id'] == n['id']);
          if (idx != -1) {
            notifications[idx] = Map.from(notifications[idx])..['is_read'] = true;
          }
          if (unreadCount > 0) unreadCount--;
          _openNotification = Map.from(n)..['is_read'] = true;
        });
      } catch (_) {}
    }
  }

  // ── Close detail view, go back to list ──
  void _closeDetail() {
    setState(() => _openNotification = null);
  }

  // ── Clear (delete) a notification permanently ──
  Future<void> _clearNotification(Map n) async {
    try {
      await ApiService.clearNotification(n['id']);
      // Re-fetch fresh count from backend after deletion
      final fresh = await ApiService.getNotifications();
      setState(() {
        notifications.removeWhere((x) => x['id'] == n['id']);
        unreadCount   = fresh['unread_count'] ?? 0;
        _openNotification = null;
      });
    } catch (_) {
      setState(() => _openNotification = null);
    }
  }

  IconData _icon(String type) => switch (type) {
    'repayment'   => Icons.payments_rounded,
    'loan_status' => Icons.account_balance_rounded,
    _             => Icons.notifications_rounded,
  };

  Color _color(String type) => switch (type) {
    'repayment'   => kGreen,
    'loan_status' => kBlue,
    _             => Colors.orange,
  };

  String _timeAgo(String? createdAt) {
    if (createdAt == null) return '';
    final dt = DateTime.tryParse(createdAt);
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24)   return '${diff.inHours}h ago';
    if (diff.inDays < 7)     return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Detail view ──
    if (_openNotification != null) {
      return _DetailView(
        notification: _openNotification!,
        isDark:       isDark,
        icon:         _icon(_openNotification!['type'] ?? ''),
        color:        _color(_openNotification!['type'] ?? ''),
        timeAgo:      _timeAgo(_openNotification!['created_at']),
        onClose:      _closeDetail,
        onClear:      () => _clearNotification(_openNotification!),
      );
    }

    // ── List view ──
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
      appBar: AppBar(
        backgroundColor: kBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Notifications',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [kBlue, kGreen])),
          ),
        ),
        actions: const [],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: kBlue))
          : notifications.isEmpty
              ? _emptyState(isDark)
              : RefreshIndicator(
                  onRefresh: _load,
                  color: kBlue,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemCount: notifications.length,
                    itemBuilder: (_, i) => _NotificationCard(
                      notification: notifications[i],
                      isDark:  isDark,
                      icon:    _icon(notifications[i]['type'] ?? ''),
                      color:   _color(notifications[i]['type'] ?? ''),
                      timeAgo: _timeAgo(notifications[i]['created_at']),
                      onRead:  () => _openDetail(notifications[i]),
                    ),
                  ),
                ),
    );
  }

  Widget _emptyState(bool isDark) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: kBlue.withValues(alpha: 0.07), shape: BoxShape.circle),
          child: const Icon(Icons.notifications_none_rounded,
              size: 56, color: kBlue),
        ),
        const SizedBox(height: 16),
        const Text('No notifications yet',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: kBlue)),
        const SizedBox(height: 8),
        Text(
          'You will be notified when there are\nupdates on your loans or repayments.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13, color: Colors.grey[600], height: 1.5),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  Detail View — shown when a notification is opened
// ════════════════════════════════════════════════════════════════
class _DetailView extends StatelessWidget {
  final Map        notification;
  final bool       isDark;
  final IconData   icon;
  final Color      color;
  final String     timeAgo;
  final VoidCallback onClose;
  final VoidCallback onClear;

  const _DetailView({
    required this.notification,
    required this.isDark,
    required this.icon,
    required this.color,
    required this.timeAgo,
    required this.onClose,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
      appBar: AppBar(
        backgroundColor: kBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text('Notification',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [kBlue, kGreen])),
          ),
        ),
        // ── X button to go back to the list ──
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: onClose,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon + type badge ──
            Row(children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    notification['type'] == 'repayment'
                        ? 'Repayment'
                        : 'Loan update',
                    style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 4),
                Row(children: [
                  Icon(Icons.access_time_rounded,
                      size: 11,
                      color: isDark ? Colors.white38 : Colors.black38),
                  const SizedBox(width: 4),
                  Text(timeAgo,
                      style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white38 : Colors.black38)),
                ]),
              ]),
            ]),

            const SizedBox(height: 24),

            // ── Message card ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF111827) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                      color: color.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // Title
                Text(
                  notification['title'] ?? '',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                // Divider
                Container(
                    height: 1,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.07)
                        : Colors.black.withValues(alpha: 0.07)),
                const SizedBox(height: 12),
                // Body
                Text(
                  notification['body'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black54,
                    height: 1.6,
                  ),
                ),
              ]),
            ),

            const Spacer(),

            // ── Clear message button ──
            GestureDetector(
              onTap: onClear,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent, size: 20),
                  SizedBox(width: 10),
                  Text('Clear message',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent,
                          letterSpacing: 0.3)),
                ]),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  Notification Card — shown in list view
// ════════════════════════════════════════════════════════════════
class _NotificationCard extends StatelessWidget {
  final Map        notification;
  final bool       isDark;
  final IconData   icon;
  final Color      color;
  final String     timeAgo;
  final VoidCallback onRead;

  const _NotificationCard({
    required this.notification,
    required this.isDark,
    required this.icon,
    required this.color,
    required this.timeAgo,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = notification['is_read'] == false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnread
            ? (isDark ? color.withValues(alpha: 0.12) : color.withValues(alpha: 0.06))
            : (isDark ? const Color(0xFF111827) : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread
              ? color.withValues(alpha: 0.3)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.06)),
          width: isUnread ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Icon ──
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),

        // ── Content ──
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // Title row with unread dot
            Row(children: [
              Expanded(
                child: Text(
                  notification['title'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isUnread ? FontWeight.w700 : FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: color, shape: BoxShape.circle),
                ),
            ]),
            const SizedBox(height: 4),

            // Body preview (2 lines max)
            Text(
              notification['body'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                  height: 1.4),
            ),
            const SizedBox(height: 8),

            // Bottom row: time + type badge + READ button
            Row(children: [
              Icon(Icons.access_time_rounded,
                  size: 11,
                  color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 4),
              Text(timeAgo,
                  style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white38 : Colors.black38)),
              const Spacer(),
              // ── READ button ──
              GestureDetector(
                onTap: onRead,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isUnread ? 'Read' : 'View',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  NotificationBell — add to any AppBar actions
// ════════════════════════════════════════════════════════════════
class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell>
    with WidgetsBindingObserver {
  int _unread = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCount();
    // Poll every 10 seconds so bell stays in sync with any changes
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _loadCount());
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-fetch when app comes back to foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _loadCount();
  }

  Future<void> _loadCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) {
        if (mounted) setState(() => _unread = 0);
        return;
      }
      final data = await ApiService.getNotifications();
      if (mounted) setState(() => _unread = data['unread_count'] ?? 0);
    } catch (_) {
      if (mounted) setState(() => _unread = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationsPage()),
        );
        // Always re-fetch from backend when returning — ensures bell is accurate
        await _loadCount();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_rounded,
                color: Colors.white, size: 26),
            if (_unread > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                  constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    _unread > 99 ? '99+' : '$_unread',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



